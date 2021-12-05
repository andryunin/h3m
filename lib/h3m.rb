# frozen_string_literal: true

require_relative "h3m/version"
require "zlib"
require "bindata"

module H3m
  class Error < StandardError; end

  autoload :Map,          "h3m/map.rb"
  autoload :MapError,     "h3m/map.rb"
  autoload :Player,       "h3m/player.rb"
  autoload :Records,      "h3m/records.rb"
end
