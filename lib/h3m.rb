require "h3m/version"
require "zlib"

module H3m
  
  class Map
    # Map representation
    #
    # Example:
    #   >> map = H3m::Map.new("some-map-file.h3m")
    #   >> map.version
    #   => :SoD

    attr_reader :path

    def initialize(path)
      @path = path
      @gzip_file = File.new(path)
    end

    def file
      @file ||= Zlib::GzipReader.new(@gzip_file)
    end

    def version
    end
  end

end
