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

    def initialize(path)
      @path = path
      @gzip_file = File.new(path)
    end

    def file
      @file ||= Zlib::GzipReader.new(@gzip_file)
    end

    def record
      @record ||= H3m::MapRecord.read(file)
    end

    def name
      record.map_name
    end

    def description
      record.map_desc
    end

    # Get extension 
    # @return [Symbol] :SoD, :AB or :RoE
    def version
      @version ||= case record.heroes_version
        when 0x0E then :RoE
        when 0x15 then :AB
        when 0x1C then :SoD
        else
          raise MapError, "unknown map version"
      end
    end

    def size
      @size ||= case record.map_size
        when 36  then :S
        when 72  then :M
        when 108 then :L
        when 144 then :XL
        else
          raise MapError, "unknown map size"
      end
    end

    def difficulty
      @difficulty ||= case record.map_difficulty
        when 0 then :easy
        when 1 then :normal
        when 2 then :hard
        when 3 then :expert
        when 4 then :impossible
        else
          raise MapError, "unknown map difficulty"
      end
    end

    def has_subterranean?
      record.map_has_subterranean != 0
    end
  end

end