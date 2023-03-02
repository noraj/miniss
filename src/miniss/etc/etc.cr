module Miniss::Etc
  def self.getpwuid(uid)
    File.read_lines("/etc/passwd").each_with_index do |line, i|
      entry = line.split(":", remove_empty: false)
      return entry[0] if entry[2] == uid
    end
  end
end
