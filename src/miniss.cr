require "./miniss/*"
require "./miniss/etc/**"
# TODO: Write documentation for `Miniss`
module Miniss
  VERSION = {{ `shards version "#{__DIR__}"`.chomp.stringify }}
end
