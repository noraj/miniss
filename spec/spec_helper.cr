require "spec"
require "../src/miniss.cr"

def create_test_minisssocket_tcp_ipv4
  so = Miniss::MinissSocket.new(:tcp, 4_u8)
  line = "   4: 0100007F:A3C3 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 157858 1 0000000085c4fdbb 99 0 0 10 0                     " # 127.0.0.1:41923       0.0.0.0:0             LISTEN      root (0)
  so.parse_line(line)
  so
end
