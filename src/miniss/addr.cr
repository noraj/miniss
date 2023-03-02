require "../miniss"

module Miniss
  def self.decode_addr(addr)
    ip, port = addr.split(":", remove_empty: true)
    ip = ip.scan(/.{2}/).reverse_each.join('.'){ |x| x[0].to_i(16) }
    port = port.to_i(16).to_s
    "#{ip}:#{port}"
  end
end
