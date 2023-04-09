# Project internal
require "../../miniss"
# Crystal internal
require "colorize"
# External
require "docopt"

# :nodoc:
module Miniss::Cli
  # Find the max size of an object atribute in an Array in order to set a justification size.
  #
  # `sockets_obj` is an instance of `Miniss::Sockets`.
  private def self.find_max_just(sockets_obj : Sockets) : Hash
    just = {
      type:  4, # type size is constant (3), label size is 4, so fix just to 5
      laddr: 0,
      raddr: 0,
      state: 0,
    }.to_h
    just_min = { # min size due to the label size
      type:  "type".size,
      laddr: "local address".size,
      raddr: "remote address".size,
      state: "state".size,
    }
    sockets_obj.all.each do |so|
      just[:laddr] = so.laddr.size if so.laddr.size > just[:laddr]
      just[:raddr] = so.raddr.size if so.raddr.size > just[:raddr]
      just[:state] = so.state.size if so.state.size > just[:state]
    end
    # Keep the highest value betwenn the min just size and the max attr size
    # Also add +1 so that columns are not joint
    just[:type], just[:laddr], just[:raddr], just[:state] = [just.values, just_min.values].transpose.map { |x| x.max + 1 }
    just
  end

  def self.argparser
    # disable colors on usage while https://github.com/chenkovsky/docopt.cr/issues/9
    doc = <<-DOCOPT
    #{"miniss".colorize.light_magenta} v#{Miniss::VERSION.colorize.bold}

    #{"Usage:".colorize.light_cyan.toggle(false)}
      miniss [--tcp | --udp] [--ipv4 | --ipv6] [--debug --no-color]
      miniss -h | --help
      miniss --version

    #{"Options:".colorize.light_cyan}
      -u --udp      Show UDP sockets.
      -t --tcp      Show TCP sockets.
      -4 --ipv4     Show IPv4 sockets.
      -6 --ipv6     Show IPv6 sockets.
      --debug       Display arguments.
      --no-color    Disable colorized output (NO_COLOR environment variable is respected too).
      -h --help     Show this screen.
      --version     Show version.

    #{"Examples:".colorize.light_cyan}
      miniss --udp
      miniss -t6

    #{"Project:".colorize.light_cyan}
      #{"author".colorize.underline} (https://pwn.by/noraj / https://twitter.com/noraj_rawsec)
      #{"source".colorize.underline} (https://github.com/noraj/miniss)
      #{"documentation".colorize.underline} (https://noraj.github.io/miniss)
    DOCOPT
    Docopt.docopt(doc, version: Miniss::VERSION)
  end

  def self.run
    args = argparser
    Colorize.enabled = false if args["--no-color"]
    puts args if args["--debug"]
    # if no args, display everything
    display = {:tcp => true, :udp => true, :ipv4 => true, :ipv6 => true}
    # arguments are filters, hide the opposite of what is asked
    display[:tcp] = false if args["--udp"]
    display[:udp] = false if args["--tcp"]
    display[:ipv6] = false if args["--ipv4"]
    display[:ipv4] = false if args["--ipv6"]
    sockets = Miniss::Sockets.new
    just = find_max_just(sockets).values # calculate justifications
    # display headers
    headers = "type".ljust(just[0]) + "local address".ljust(just[1]) + "remote address".ljust(just[2]) + "state".ljust(just[3]) + "username (uid)"
    puts headers.colorize.bold
    # display sockets
    sockets.all.each do |so|
      if ((so.type == :tcp && display[:tcp]) && ((so.ipv == 4 && display[:ipv4]) || (so.ipv == 6 && display[:ipv6]))) || ((so.type == :udp && display[:udp]) && ((so.ipv == 4 && display[:ipv4]) || (so.ipv == 6 && display[:ipv6])))
        color_type = so.type == :tcp ? :light_magenta : :light_cyan
        type = so.type.to_s.ljust(just[0]).colorize(color_type)
        color_ip_addr = so.ipv == 4 ? :light_red : :light_green
        color_ip_port = so.ipv == 4 ? :light_blue : :light_yellow
        laddr, lport = so.laddr.to_s.ljust(just[1]).reverse.split(':', 2).reverse.map(&.reverse)
        laddr = laddr.colorize(color_ip_addr)
        lport = lport.colorize(color_ip_port)
        raddr, rport = so.raddr.to_s.ljust(just[2]).reverse.split(':', 2).reverse.map(&.reverse)
        raddr = raddr.colorize(color_ip_addr)
        rport = rport.colorize(color_ip_port)
        puts "#{type}#{laddr}:#{lport}#{raddr}:#{rport}#{so.state.ljust(just[3])}#{so.uname} (#{so.uid})"
      end
    end
  end
end
