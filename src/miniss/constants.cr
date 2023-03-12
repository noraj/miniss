require "../miniss"

module Miniss
  # TCP states code mapping.
  #
  # Used in `Miniss::Socket#parse_line`.
  #
  # NOTE: Parsed from `/usr/src/linux/include/net/tcp_states.h`.
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
    "0C" => "NEW_SYN_RECV"
  }
end
