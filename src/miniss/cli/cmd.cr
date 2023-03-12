require "../../miniss"

# :nodoc:
module Miniss::Cli
  def self.run
    puts "local address".ljust(22) + "remote address".ljust(22) + "state".ljust(12) + "username (uid)"
    File.read_lines("/proc/net/tcp").each_with_index do |line, i|
      so = Miniss::Socket.new(:tcp, 4_u8)
      unless i == 0 # skip headers
        so.parse_line(line)
        puts "#{so.laddr.ljust(22)}#{so.raddr.ljust(22)}#{so.state.ljust(12)}#{so.uname} (#{so.uid})"
      end
    end
  end
end
