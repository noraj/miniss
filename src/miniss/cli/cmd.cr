require "../../miniss"

# :nodoc:
module Miniss::Cli
  JUST = [5,48,48,12]
  def self.run
    puts "type".ljust(JUST[0]) + "local address".ljust(JUST[1]) + "remote address".ljust(JUST[2]) + "state".ljust(JUST[3]) + "username (uid)"
    File.read_lines("/proc/net/tcp").each_with_index do |line, i|
      so = Miniss::MinissSocket.new(:tcp, 4_u8)
      unless i == 0 # skip headers
        so.parse_line(line)
        puts "#{so.type.to_s.ljust(JUST[0])}#{so.laddr.ljust(JUST[1])}#{so.raddr.ljust(JUST[2])}#{so.state.ljust(JUST[3])}#{so.uname} (#{so.uid})"
      end
    end
    File.read_lines("/proc/net/tcp6").each_with_index do |line, i|
      so = Miniss::MinissSocket.new(:tcp, 6_u8)
      unless i == 0 # skip headers
        so.parse_line(line)
        puts "#{so.type.to_s.ljust(JUST[0])}#{so.laddr.ljust(JUST[1])}#{so.raddr.ljust(JUST[2])}#{so.state.ljust(JUST[3])}#{so.uname} (#{so.uid})"
      end
    end
    File.read_lines("/proc/net/udp").each_with_index do |line, i|
      so = Miniss::MinissSocket.new(:udp, 4_u8)
      unless i == 0 # skip headers
        so.parse_line(line)
        puts "#{so.type.to_s.ljust(JUST[0])}#{so.laddr.ljust(JUST[1])}#{so.raddr.ljust(JUST[2])}#{so.state.ljust(JUST[3])}#{so.uname} (#{so.uid})"
      end
    end
    File.read_lines("/proc/net/udp6").each_with_index do |line, i|
      so = Miniss::MinissSocket.new(:udp, 6_u8)
      unless i == 0 # skip headers
        so.parse_line(line)
        puts "#{so.type.to_s.ljust(JUST[0])}#{so.laddr.ljust(JUST[1])}#{so.raddr.ljust(JUST[2])}#{so.state.ljust(JUST[3])}#{so.uname} (#{so.uid})"
      end
    end
  end
end
