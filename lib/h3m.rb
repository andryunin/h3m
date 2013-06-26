require "h3m/version"
require "zlib"

module H3m
  autoload :Map,          "h3m/map.rb"
  autoload :MapError,     "h3m/map.rb"
  autoload :Player,       "h3m/player.rb"
  autoload :PlayerError,  "h3m/player.rb"
  autoload :MapRecord,    "h3m/records.rb"
  autoload :PlayerRecord, "h3m/records.rb"
end
