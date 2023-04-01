require "../../miniss"

# :nodoc:
module Miniss::Cli
  # Find the max size of an object atribute in an Array in order to set a justification size.
  #
  # `sockets_obj` is an instance of `Miniss::Sockets`.
  private def self.find_max_just(sockets_obj : Sockets) : Hash
    just = {
      type: 4, # type size is constant (3), label size is 4, so fix just to 5
      laddr: 0,
      raddr: 0,
      state: 0
    }.to_h
    just_min = { # min size due to the label size
      type: "type".size,
      laddr: "local address".size,
      raddr: "remote address".size,
      state: "state".size
    }
    all_sockets = sockets_obj.tcpv4 + sockets_obj.tcpv6 + sockets_obj.udpv4 + sockets_obj.udpv6
    all_sockets.each do |so|
      just[:laddr] = so.laddr.size if so.laddr.size > just[:laddr]
      just[:raddr] = so.raddr.size if so.raddr.size > just[:raddr]
      just[:state] = so.state.size if so.state.size > just[:state]
    end
    # Keep the highest value betwenn the min just size and the max attr size
    # Also add +1 so that columns are not joint
    just[:type], just[:laddr], just[:raddr], just[:state] = [just.values,just_min.values].transpose.map { |x| x.max + 1 }
    just
  end

  def self.run
    sockets = Miniss::Sockets.new
    just = find_max_just(sockets).values
    puts "type".ljust(just[0]) + "local address".ljust(just[1]) + "remote address".ljust(just[2]) + "state".ljust(just[3]) + "username (uid)"
    sockets.tcpv4.each do |so|
      puts "#{so.type.to_s.ljust(just[0])}#{so.laddr.ljust(just[1])}#{so.raddr.ljust(just[2])}#{so.state.ljust(just[3])}#{so.uname} (#{so.uid})"
    end
    sockets.tcpv6.each do |so|
      puts "#{so.type.to_s.ljust(just[0])}#{so.laddr.ljust(just[1])}#{so.raddr.ljust(just[2])}#{so.state.ljust(just[3])}#{so.uname} (#{so.uid})"
    end
    sockets.udpv4.each do |so|
      puts "#{so.type.to_s.ljust(just[0])}#{so.laddr.ljust(just[1])}#{so.raddr.ljust(just[2])}#{so.state.ljust(just[3])}#{so.uname} (#{so.uid})"
    end
    sockets.udpv6.each do |so|
      puts "#{so.type.to_s.ljust(just[0])}#{so.laddr.ljust(just[1])}#{so.raddr.ljust(just[2])}#{so.state.ljust(just[3])}#{so.uname} (#{so.uid})"
    end
  end
end
