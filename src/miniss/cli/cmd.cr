require "../../miniss"

# :nodoc:
module Miniss::Cli
  def self.run
    puts "local address".ljust(22) + "remote address".ljust(22) + "state".ljust(12) + "username (uid)"
    File.read_lines("/proc/net/tcp").each_with_index do |line, i|
      entry = line.split(" ", remove_empty: true)
      unless i == 0 # skip headers
        laddr = Miniss.decode_addr(entry[1])
        raddr = Miniss.decode_addr(entry[2])
        state = Miniss::TCP_STATES[entry[3]]
        uid = entry[7]
        uname = Miniss::Etc.getpwuid(uid)
        puts "#{laddr.ljust(22)}#{raddr.ljust(22)}#{state.ljust(12)}#{uname} (#{uid})"
      end
    end
  end
end
