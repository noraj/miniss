require "spec"
require "../src/miniss.cr"

def create_test_socket_tcp_ipv4
  so = Miniss::Socket.new(:tcp, 4_u8)
  line = "   4: 0100007F:A3C3 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 157858 1 0000000085c4fdbb 99 0 0 10 0                     " # tcp 127.0.0.1:41923       0.0.0.0:0             LISTEN      root (0)
  so.parse_line(line)
  so
end

def create_test_socket_udp_ipv4
  so = Miniss::Socket.new(:udp, 4_u8)
  line = " 2807: 5B01A8C0:0044 00000000:0000 07 00000000:00000000 00:00000000 00000000   981        0 17170 2 00000000da060629 0         " # udp  192.168.1.91:68                                 0.0.0.0:0                                       CLOSE       systemd-network (981)
  so.parse_line(line)
  so
end

def create_test_socket_tcp_ipv6
  so = Miniss::Socket.new(:tcp, 6_u8)
  line = "   0: 00000000000000000000000000000000:14EB 00000000000000000000000000000000:0000 0A 00000000:00000000 00:00000000 00000000   980        0 17992 1 00000000fe246dd7 99 0 0 10 5" # tcp  [::]:5355                                       [::]:0                                          LISTEN      systemd-resolve (980)
  so.parse_line(line)
  so
end

def create_test_socket_udp_ipv6
  so = Miniss::Socket.new(:udp, 6_u8)
  line = " 3285: 000080FE00000000FF005450B6AD1DFE:0222 00000000000000000000000000000000:0000 07 00000000:00000000 00:00000000 00000000   981        0 17289 2 0000000041d378f3 0" # udp  [fe80::5054:ff:fe1d:adb6]:546                   [::]:0                                          CLOSE       systemd-network (981)
  so.parse_line(line)
  so
end
