require 'bindata'

module H3m

  class PlayerRecord < BinData::Record
    endian :little

    uint8 :max_level

    uint8 :can_be_human
    uint8 :can_be_computer
    uint8 :computer_behaviour

    uint8  :has_town_on_start
    uint16 :can_have_town_types
    uint8  :has_random_town
    uint8  :has_main_town

    uint8 :main_town_has_hero, onlyif: :has_main_town?
    uint8 :main_town_type,     onlyif: :has_main_town?
    uint8 :main_town_coord_x,  onlyif: :has_main_town?
    uint8 :main_town_coord_y,  onlyif: :has_main_town?
    uint8 :main_town_coord_z,  onlyif: :has_main_town?

    def has_main_town?
      has_main_town.nonzero?
    end
  end

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

    array  :players, type: :player_record, initial_length: 8
  end

end