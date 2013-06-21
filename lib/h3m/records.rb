require 'bindata'

module H3m

  class MapRecord < BinData::Record
    endian :little

    uint32 :heroes_version
    uint8  :map_has_hero
    uint32 :map_size
    uint8  :map_has_subterranean

    uint32 :map_name_size
    string :map_name, read_length: :map_name_size

    uint32 :map_desc_size
    string :map_desc, read_length: :map_desc_size

    uint8  :map_difficulty
  end

end