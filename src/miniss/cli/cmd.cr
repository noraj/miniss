require "../../miniss"

# :nodoc:
module Miniss::Cli
  JUST = [5, 48, 48, 12]

  def self.run
    puts "type".ljust(JUST[0]) + "local address".ljust(JUST[1]) + "remote address".ljust(JUST[2]) + "state".ljust(JUST[3]) + "username (uid)"
    sockets = Miniss::Sockets.new
    sockets.tcpv4.each do |so|
      puts "#{so.type.to_s.ljust(JUST[0])}#{so.laddr.ljust(JUST[1])}#{so.raddr.ljust(JUST[2])}#{so.state.ljust(JUST[3])}#{so.uname} (#{so.uid})"
    end
    sockets.tcpv6.each do |so|
      puts "#{so.type.to_s.ljust(JUST[0])}#{so.laddr.ljust(JUST[1])}#{so.raddr.ljust(JUST[2])}#{so.state.ljust(JUST[3])}#{so.uname} (#{so.uid})"
    end
    sockets.udpv4.each do |so|
      puts "#{so.type.to_s.ljust(JUST[0])}#{so.laddr.ljust(JUST[1])}#{so.raddr.ljust(JUST[2])}#{so.state.ljust(JUST[3])}#{so.uname} (#{so.uid})"
    end
    sockets.udpv6.each do |so|
      puts "#{so.type.to_s.ljust(JUST[0])}#{so.laddr.ljust(JUST[1])}#{so.raddr.ljust(JUST[2])}#{so.state.ljust(JUST[3])}#{so.uname} (#{so.uid})"
    end
  end
end
