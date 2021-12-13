# frozen_string_literal: true

require_relative "h3m/version"
require "zlib"
require "bindata"

# H3m is parser for Heroes of Might and Magic III maps
module H3m
  class Error < StandardError; end
  class FormatError < Error; end

  autoload :Map,          "h3m/map.rb"
  autoload :MapError,     "h3m/map.rb"
  autoload :Player,       "h3m/player.rb"
  autoload :Records,      "h3m/records.rb"
  autoload :RecordUtil,   "h3m/record_util.rb"
end
