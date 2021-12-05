# frozen_string_literal: true

module H3m
  class MapError < StandardError
  end

  class Map
    # Map representation
    #
    # Example:
    #   >> map = H3m::Map.new("some-map-file.h3m")
    #   >> map.version
    #   => :SoD

    attr_reader :path

    def initialize(file, unzipped = false)
      if file.respond_to? :read
        # Consider file argument is IO-like object
        @path = file.path if file.respond_to? :path
        if unzipped
          @file = file
        else
          @gzip_file = file
        end
      else
        # Consider file argument is a file path
        @path = file
        if unzipped
          @file = File.new(path)
        else
          @gzip_file = File.new(path)
        end
      end
    end

    def file
      @file ||= Zlib::GzipReader.new(@gzip_file)
    end

    def record
      @record ||= H3m::Records::MapRecord.read(file)
    end

    def name
      record.map_name
    end

    def description
      record.map_desc
    end

    def game_version
      record.game_version.to_sym
    end

    def size
      case record.map_size
      # Original series sizes
      when 36  then :S
      when 72  then :M
      when 108 then :L
      when 144 then :XL
      # HotA map sizes
      when 180 then :H
      when 216 then :XH
      when 252 then :G
      else
        raise FormatError, "unknown map size value: #{record.map_size}"
      end
    end

    def difficulty
      case record.map_difficulty
      when 0 then :easy
      when 1 then :normal
      when 2 then :hard
      when 3 then :expert
      when 4 then :impossible
      else
        raise FormatError, "unknown map difficulty: #{record.map_difficulty}"
      end
    end

    def subterranean_level?
      record.map_has_subterranean != 0
    end

    def players
      @players ||= record.players.each_with_index.map do |rec, i|
        Player.new(rec, i)
      end
    end
  end
end
