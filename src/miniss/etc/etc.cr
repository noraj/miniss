# Rudimentary implementation of Ruby's [Etc module](https://ruby-doc.org/3.2.1/exts/etc/Etc.htm).
#
# > The Etc module provides access to information typically stored in files in the `/etc` directory on Unix systems.
#
# Only implements the methods required for miniss.
module Miniss::Etc
  # Returns the username with the given integer _uid_.
  #
  # Returns an empty string if the user is not found in `/etc/passwd`.
  #
  # NOTE: Ruby's [getpwuid()](https://ruby-doc.org/3.2.1/exts/etc/Etc.html#method-c-getpwuid).
  #
  # Example:
  #
  # ```
  # Miniss::Etc.getpwuid(0) # => "root"
  # ```
  def self.getpwuid(uid)
    File.read_lines("/etc/passwd").each_with_index do |line, i|
      entry = line.split(":", remove_empty: false)
      return entry[0] if entry[2] == uid.to_s
    end
    return ""
  end
end
