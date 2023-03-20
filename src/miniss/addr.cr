require "socket"
require "../miniss"

module Miniss
  # Returns the decoded IPv4 address + port from hexadecimal format (low nibble) to the dotted decimal format.
  # Returns the decoded IPv6 address + port from hexadecimal format (low nibble) to the double-dotted hexadecimal format.
  #
  # Example:
  #
  # ```
  # Miniss.decode_addr("3500007F:0035", 4_u8) # => "127.0.0.53:53"
  # Miniss.decode_addr("000080FE00000000FF005450B6AD1DFE:0222", 6_u8) # => "[fe80::5054:ff:fe1d:adb6]:546"
  # Miniss.decode_addr("00000000000000000000000000000000:14E9", 6_u8) # => "[::]:5353"
  # ```
  def self.decode_addr(addr : String, ipv : UInt8)
    ip, port = addr.split(":", remove_empty: true)
    if ipv == 4
      ip = ip.scan(/.{2}/).reverse_each.join('.', &.[0].to_i(16))
    elsif ipv == 6
      ip = ip.scan(/.{2}/).reverse_each.join("", &.[0]) # re-order
      ip = ip.scan(/.{8}/).reverse_each.join("", &.[0]) # re-order
      ip = ip.scan(/.{4}/).each.join(':', &.[0].sub(/^[0]+/, "")) # add double-dots and remove leading zeros
      ip = ip.sub(/:{3,}/, "::").downcase # strip more than two consecutive double-dots and put to lower case
      ip = "[#{ip}]" # enclose with square brackets
    end
    port = port.to_i(16).to_s
    "#{ip}:#{port}"
  end

  # Socket object, having several properties.
  #
  # Example:
  #
  # ```
  # so = Miniss::Socket.new(:tcp, 4_u8)
  # line = File.readlines("/proc/net/tcp")[1]
  # so.parse_line(line)
  # so.laddr # => "127.0.0.53:53"
  # so.state # => "LISTEN"
  # so.uname # => "systemd-resolve"
  # so.uid   # => 980
  # ```
  class MinissSocket
    # Local address (IP + port).
    property laddr : String

    # Remote address (IP + port).
    property raddr : String

    # Socket state cf. `Miniss::TCP_STATES`.
    property state : String

    # Process owner user ID.
    property uid : UInt32

    # Process owner user name.
    property uname : String

    # Socket type (TCP, UDP).
    #
    # Accepts values: `:tcp`, `:udp`.
    getter type : Symbol

    # IP version (v4, v6).
    #
    # Accepts values: `4_u8`, `6_u8`.
    getter ipv : UInt8

    # Initialize `MinissSocket` class.
    #
    # Choose the type of socket. Arguments: _type_ (cf. `#type`), _ipv_ (cf. `#ipv`).
    def initialize(type, ipv)
      @type = type # :tcp, :udp
      @ipv = ipv   # 4, 6
      @laddr = @raddr = @state = @uname = ""
      @uid = 0_u32
    end

    # Parse a socket _line_ from `/proc/net/XXX` and set `MinissSocket` instance properties.
    def parse_line(line)
      entry = line.split(" ", remove_empty: true)
      if @type == :tcp
        @state = Miniss::TCP_STATES[entry[3]]
      elsif @type == :udp
        @state = Miniss::UDP_STATES[entry[3]]
      end
      if @ipv == 4
        @laddr = Miniss.decode_addr(entry[1], 4_u8)
        @raddr = Miniss.decode_addr(entry[2], 4_u8)
      elsif @ipv == 6
        @laddr = Miniss.decode_addr(entry[1], 6_u8)
        @raddr = Miniss.decode_addr(entry[2], 6_u8)
      end
      @uid = entry[7].to_u32
      @uname = Miniss::Etc.getpwuid(@uid)
    end
  end
end
