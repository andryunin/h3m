require 'bindata'

module H3m::Records
  class HeroRecord < BinData::Record
    endian :little

    uint8  :type
    uint32 :name_size
    string :name, read_length: :name_size
  end

  class PlayerRecord < BinData::Record
    endian :little

    uint8 :can_be_human
    uint8 :can_be_computer
    uint8 :computer_behaviour

    uint8  :can_have_town_types_set
    uint16 :can_have_town_types
    uint8  :has_random_town
    uint8  :has_main_town

    uint8  :main_town_has_hero, onlyif: :has_main_town?
    uint8  :main_town_type,     onlyif: :has_main_town?
    uint8  :main_town_coord_x,  onlyif: :has_main_town?
    uint8  :main_town_coord_y,  onlyif: :has_main_town?
    uint8  :main_town_coord_z,  onlyif: :has_main_town?

    uint8  :has_random_hero

    uint8  :first_hero_type
    uint8  :first_hero_face
    uint32 :first_hero_name_size
    string :first_hero_name, read_length: :first_hero_name_size

    uint8  :unknown_offset, onlyif: :has_heroes?
    uint32 :heroes_count,   onlyif: :has_heroes?

    array  :heroes, type: :hero_record, initial_length: :heroes_count

    def has_main_town?
      has_main_town.nonzero?
    end

    def has_heroes?
      first_hero_type != 0xFF
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

    uint8  :max_level

    array  :players, type: :player_record, initial_length: 8
  end

end