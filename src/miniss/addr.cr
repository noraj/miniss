require "../miniss"

module Miniss
  def self.decode_addr(addr)
    ip, port = addr.split(":", remove_empty: true)
    ip = ip.scan(/.{2}/).reverse_each.join('.'){ |x| x[0].to_i(16) }
    port = port.to_i(16).to_s
    "#{ip}:#{port}"
  end

  class Socket
    property laddr : String
    property raddr : String
    property state : String
    property uid : UInt32
    property uname : String
    getter type : Symbol
    getter ipv : UInt8

    def initialize(type, ipv)
      @type = type # :tcp, :udp
      @ipv = ipv # 4, 6
      @laddr = @raddr = @state = @uname = ""
      @uid = 0_u32
    end

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
