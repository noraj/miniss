require "../miniss"

module Miniss
  # Returns the decoded IP (v4) address + port from hexadecimal format (low nibble) to the dotted decimal format.
  #
  # Example:
  #
  # ```
  # Miniss.decode_addr("3500007F:0035") # => "127.0.0.53:53"
  # ```
  def self.decode_addr(addr)
    ip, port = addr.split(":", remove_empty: true)
    ip = ip.scan(/.{2}/).reverse_each.join('.', &.[0].to_i(16))
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
  #
  # TODO: IPv6 and UDP support.
  class Socket
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

    # Initialize `Socket` class.
    #
    # Choose the type of socket. Arguments: _type_ (cf. `#type`), _ipv_ (cf. `#ipv`).
    def initialize(type, ipv)
      @type = type # :tcp, :udp
      @ipv = ipv   # 4, 6
      @laddr = @raddr = @state = @uname = ""
      @uid = 0_u32
    end

    # Parse a socket _line_ from `/proc/net/tcp` and set `Socket` instance properties.
    #
    # WARNING: supports only `#type` = `:tcp` and `#ipv` = `4` for now.
    def parse_line(line)
      entry = line.split(" ", remove_empty: true)
      if @type == :tcp && @ipv == 4 # /proc/net/tcp
        @laddr = Miniss.decode_addr(entry[1])
        @raddr = Miniss.decode_addr(entry[2])
        @state = Miniss::TCP_STATES[entry[3]]
        @uid = entry[7].to_u32
        @uname = Miniss::Etc.getpwuid(@uid)
      end
    end
  end
end
