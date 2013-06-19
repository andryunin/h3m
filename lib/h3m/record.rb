require 'bindata'

module H3m

  class Record < BinData::Record
    endian :little
    
    uint32 :heroes_version
    uint8  :map_has_hero
    uint32 :map_size
    uint8  :map_has_subterranean

    uint32 :map_name_size
    string :map_name, len: :map_name_size

    uint32 :map_desc_size
    string :map_desc, len: :map_desc_size
  end

end