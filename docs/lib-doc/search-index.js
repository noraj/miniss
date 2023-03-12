crystal_doc_search_index_callback({"repository_name":"miniss","body":"# miniss\n\n**miniss** (_mini ss_) displays a list of open listening sockets. It is a minimal alternative to `ss` or `netstat`.\n\nThe goal of **miniss** is not to reinvent the wheel but rather to offer a static binary that can be deployed by pentester or CTF players on containers or hardened environnement where the classical `ss` or `netstat` binaries have been removed.\n\n## Installation\n\nTODO: Write installation instructions here\n\n## Usage\n\n```\n./miniss\n```\n\n## Features\n\n- Information displayed:\n  - local address, remote address, state, username, uid\n- Type of sockets:\n  - [x] TCP\n  - [ ] UDP\n- IP version:\n  - [x] IPv4\n  - [ ] IPv6\n\n## Author\n\n- [noraj](https://pwn.by/noraj/) - creator and maintainer\n","program":{"html_id":"miniss/toplevel","path":"toplevel.html","kind":"module","full_name":"Top Level Namespace","name":"Top Level Namespace","abstract":false,"locations":[],"repository_name":"miniss","program":true,"enum":false,"alias":false,"const":false,"types":[{"html_id":"miniss/Miniss","path":"Miniss.html","kind":"module","full_name":"Miniss","name":"Miniss","abstract":false,"locations":[{"filename":"src/miniss.cr","line_number":4,"url":null},{"filename":"src/miniss/addr.cr","line_number":3,"url":null},{"filename":"src/miniss/constants.cr","line_number":3,"url":null}],"repository_name":"miniss","program":false,"enum":false,"alias":false,"const":false,"constants":[{"id":"TCP_STATES","name":"TCP_STATES","value":"{\"00\" => \"UNKNOWN\", \"FF\" => \"UNKNOWN\", \"01\" => \"ESTABLISHED\", \"02\" => \"SYN_SENT\", \"03\" => \"SYN_RECV\", \"04\" => \"FIN_WAIT1\", \"05\" => \"FIN_WAIT2\", \"06\" => \"TIME_WAIT\", \"07\" => \"CLOSE\", \"08\" => \"CLOSE_WAIT\", \"09\" => \"LAST_ACK\", \"0A\" => \"LISTEN\", \"0B\" => \"CLOSING\", \"0C\" => \"NEW_SYN_RECV\"}","doc":"TCP states code mapping.\n\nUsed in `Miniss::Socket#parse_line`.\n\nNOTE: Parsed from `/usr/src/linux/include/net/tcp_states.h`.","summary":"<p>TCP states code mapping.</p>"},{"id":"VERSION","name":"VERSION","value":"\"0.0.2\"","doc":"`miniss` version.\n\nNOTE: see all versions available [on the release page](https://github.com/noraj/miniss/releases).","summary":"<p><code>miniss</code> version.</p>"}],"doc":"Displays a list of open listening sockets. It is a minimal alternative to `ss` or `netstat`.","summary":"<p>Displays a list of open listening sockets.</p>","class_methods":[{"html_id":"decode_addr(addr)-class-method","name":"decode_addr","abstract":false,"args":[{"name":"addr","external_name":"addr","restriction":""}],"args_string":"(addr)","args_html":"(addr)","location":{"filename":"src/miniss/addr.cr","line_number":4,"url":null},"def":{"name":"decode_addr","args":[{"name":"addr","external_name":"addr","restriction":""}],"visibility":"Public","body":"ip, port = addr.split(\":\", remove_empty: true)\nip = (ip.scan(/.{2}/)).reverse_each.join('.') do |x|\n  x[0].to_i(16)\nend\nport = (port.to_i(16)).to_s\n\"#{ip}:#{port}\"\n"}}],"types":[{"html_id":"miniss/Miniss/Etc","path":"Miniss/Etc.html","kind":"module","full_name":"Miniss::Etc","name":"Etc","abstract":false,"locations":[{"filename":"src/miniss/etc/etc.cr","line_number":6,"url":null}],"repository_name":"miniss","program":false,"enum":false,"alias":false,"const":false,"namespace":{"html_id":"miniss/Miniss","kind":"module","full_name":"Miniss","name":"Miniss"},"doc":"Rudimentary implementation of Ruby's [Etc module](https://ruby-doc.org/3.2.1/exts/etc/Etc.htm).\n\n> The Etc module provides access to information typically stored in files in the `/etc` directory on Unix systems.\n\nOnly implements the methods required for miniss.","summary":"<p>Rudimentary implementation of Ruby's <a href=\"https://ruby-doc.org/3.2.1/exts/etc/Etc.htm\">Etc module</a>.</p>","class_methods":[{"html_id":"getpwuid(uid)-class-method","name":"getpwuid","doc":"Returns the username with the given integer _uid_.\n\nReturns an empty string if the user is not found in `/etc/passwd`.\n\nNOTE: Ruby's [getpwuid()](https://ruby-doc.org/3.2.1/exts/etc/Etc.html#method-c-getpwuid).\n\nExample:\n\n```\nMiniss::Etc.getpwuid(0) # => \"root\"\n```","summary":"<p>Returns the username with the given integer <em>uid</em>.</p>","abstract":false,"args":[{"name":"uid","external_name":"uid","restriction":""}],"args_string":"(uid)","args_html":"(uid)","location":{"filename":"src/miniss/etc/etc.cr","line_number":18,"url":null},"def":{"name":"getpwuid","args":[{"name":"uid","external_name":"uid","restriction":""}],"visibility":"Public","body":"(File.read_lines(\"/etc/passwd\")).each_with_index do |line, i|\n  entry = line.split(\":\", remove_empty: false)\n  if entry[2] == uid.to_s\n    return entry[0]\n  end\nend\nreturn \"\"\n"}}]},{"html_id":"miniss/Miniss/Socket","path":"Miniss/Socket.html","kind":"class","full_name":"Miniss::Socket","name":"Socket","abstract":false,"superclass":{"html_id":"miniss/Reference","kind":"class","full_name":"Reference","name":"Reference"},"ancestors":[{"html_id":"miniss/Reference","kind":"class","full_name":"Reference","name":"Reference"},{"html_id":"miniss/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/miniss/addr.cr","line_number":11,"url":null}],"repository_name":"miniss","program":false,"enum":false,"alias":false,"const":false,"namespace":{"html_id":"miniss/Miniss","kind":"module","full_name":"Miniss","name":"Miniss"},"constructors":[{"html_id":"new(type:Symbol,ipv:UInt8)-class-method","name":"new","abstract":false,"args":[{"name":"type","external_name":"type","restriction":"::Symbol"},{"name":"ipv","external_name":"ipv","restriction":"::UInt8"}],"args_string":"(type : Symbol, ipv : UInt8)","args_html":"(type : Symbol, ipv : UInt8)","location":{"filename":"src/miniss/addr.cr","line_number":20,"url":null},"def":{"name":"new","args":[{"name":"type","external_name":"type","restriction":"::Symbol"},{"name":"ipv","external_name":"ipv","restriction":"::UInt8"}],"visibility":"Public","body":"_ = allocate\n_.initialize(type, ipv)\nif _.responds_to?(:finalize)\n  ::GC.add_finalizer(_)\nend\n_\n"}}],"instance_methods":[{"html_id":"ipv:UInt8-instance-method","name":"ipv","abstract":false,"location":{"filename":"src/miniss/addr.cr","line_number":18,"url":null},"def":{"name":"ipv","return_type":"UInt8","visibility":"Public","body":"@ipv"}},{"html_id":"laddr:String-instance-method","name":"laddr","abstract":false,"location":{"filename":"src/miniss/addr.cr","line_number":12,"url":null},"def":{"name":"laddr","return_type":"String","visibility":"Public","body":"@laddr"}},{"html_id":"laddr=(laddr:String)-instance-method","name":"laddr=","abstract":false,"args":[{"name":"laddr","external_name":"laddr","restriction":"String"}],"args_string":"(laddr : String)","args_html":"(laddr : String)","location":{"filename":"src/miniss/addr.cr","line_number":12,"url":null},"def":{"name":"laddr=","args":[{"name":"laddr","external_name":"laddr","restriction":"String"}],"visibility":"Public","body":"@laddr = laddr"}},{"html_id":"parse_line(line)-instance-method","name":"parse_line","abstract":false,"args":[{"name":"line","external_name":"line","restriction":""}],"args_string":"(line)","args_html":"(line)","location":{"filename":"src/miniss/addr.cr","line_number":27,"url":null},"def":{"name":"parse_line","args":[{"name":"line","external_name":"line","restriction":""}],"visibility":"Public","body":"entry = line.split(\" \", remove_empty: true)\nif (@type == (:tcp)) && (@ipv == 4)\n  @laddr = Miniss.decode_addr(entry[1])\n  @raddr = Miniss.decode_addr(entry[2])\n  @state = Miniss::TCP_STATES[entry[3]]\n  @uid = entry[7].to_u32\n  @uname = Miniss::Etc.getpwuid(@uid)\nend\n"}},{"html_id":"raddr:String-instance-method","name":"raddr","abstract":false,"location":{"filename":"src/miniss/addr.cr","line_number":13,"url":null},"def":{"name":"raddr","return_type":"String","visibility":"Public","body":"@raddr"}},{"html_id":"raddr=(raddr:String)-instance-method","name":"raddr=","abstract":false,"args":[{"name":"raddr","external_name":"raddr","restriction":"String"}],"args_string":"(raddr : String)","args_html":"(raddr : String)","location":{"filename":"src/miniss/addr.cr","line_number":13,"url":null},"def":{"name":"raddr=","args":[{"name":"raddr","external_name":"raddr","restriction":"String"}],"visibility":"Public","body":"@raddr = raddr"}},{"html_id":"state:String-instance-method","name":"state","abstract":false,"location":{"filename":"src/miniss/addr.cr","line_number":14,"url":null},"def":{"name":"state","return_type":"String","visibility":"Public","body":"@state"}},{"html_id":"state=(state:String)-instance-method","name":"state=","abstract":false,"args":[{"name":"state","external_name":"state","restriction":"String"}],"args_string":"(state : String)","args_html":"(state : String)","location":{"filename":"src/miniss/addr.cr","line_number":14,"url":null},"def":{"name":"state=","args":[{"name":"state","external_name":"state","restriction":"String"}],"visibility":"Public","body":"@state = state"}},{"html_id":"type:Symbol-instance-method","name":"type","abstract":false,"location":{"filename":"src/miniss/addr.cr","line_number":17,"url":null},"def":{"name":"type","return_type":"Symbol","visibility":"Public","body":"@type"}},{"html_id":"uid:UInt32-instance-method","name":"uid","abstract":false,"location":{"filename":"src/miniss/addr.cr","line_number":15,"url":null},"def":{"name":"uid","return_type":"UInt32","visibility":"Public","body":"@uid"}},{"html_id":"uid=(uid:UInt32)-instance-method","name":"uid=","abstract":false,"args":[{"name":"uid","external_name":"uid","restriction":"UInt32"}],"args_string":"(uid : UInt32)","args_html":"(uid : UInt32)","location":{"filename":"src/miniss/addr.cr","line_number":15,"url":null},"def":{"name":"uid=","args":[{"name":"uid","external_name":"uid","restriction":"UInt32"}],"visibility":"Public","body":"@uid = uid"}},{"html_id":"uname:String-instance-method","name":"uname","abstract":false,"location":{"filename":"src/miniss/addr.cr","line_number":16,"url":null},"def":{"name":"uname","return_type":"String","visibility":"Public","body":"@uname"}},{"html_id":"uname=(uname:String)-instance-method","name":"uname=","abstract":false,"args":[{"name":"uname","external_name":"uname","restriction":"String"}],"args_string":"(uname : String)","args_html":"(uname : String)","location":{"filename":"src/miniss/addr.cr","line_number":16,"url":null},"def":{"name":"uname=","args":[{"name":"uname","external_name":"uname","restriction":"String"}],"visibility":"Public","body":"@uname = uname"}}]}]}]}})