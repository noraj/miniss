require "../miniss"

module Miniss
  # TCP states code mapping.
  #
  # Used in `Miniss::MinissSocket#parse_line`.
  #
  # NOTE: Parsed from `/usr/src/linux/include/net/tcp_states.h`. I made the choice not to use the same words as `ss` (https://github.com/sivasankariit/iproute2/blob/1179ab033c31d2c67f406be5bcd5e4c0685855fe/misc/ss.c#L400-L413).
  TCP_STATES = {
    "00" => "UNKNOWN",
    "FF" => "UNKNOWN",
    "01" => "ESTABLISHED",
    "02" => "SYN_SENT",
    "03" => "SYN_RECV",
    "04" => "FIN_WAIT1",
    "05" => "FIN_WAIT2",
    "06" => "TIME_WAIT",
    "07" => "CLOSE",
    "08" => "CLOSE_WAIT",
    "09" => "LAST_ACK",
    "0A" => "LISTEN",
    "0B" => "CLOSING",
    "0C" => "NEW_SYN_RECV",
  }

  # UDP "states" (UDP is stateless) code mapping.
  #
  # Used in `Miniss::MinissSocket#parse_line`.
  #
  # NOTE: `sk_state` in `/usr/src/linux/include/net/udp.h` is always ESTABLISHED or CLOSE (`ss` shows UNCONN for unconnected).
  UDP_STATES = TCP_STATES
end
