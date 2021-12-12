# frozen_string_literal: true

require "bindata"

module H3m
  module Records
    # Hero BinData record
    class HeroRecord < BinData::Record
      endian :little

      uint8  :hero_type
      uint32 :name_size
      string :name, read_length: :name_size
    end

    # Player info Bindata record
    class PlayerRecord < BinData::Record
      endian :little

      uint8 :can_be_human
      uint8 :can_be_ai
      uint8 :ai_behaviour

      skip length: 1, onlyif: -> { %w[SoD WoG].include?(game_version) }

      # RoE has no Conflux
      uint8  :allowed_factions_roe, onlyif: -> { game_version == "RoE" }
      uint16 :allowed_factions_post_roe, onlyif: -> { game_version != "RoE" }
      uint8  :is_random_faction

      def allowed_factions
        allowed_factions_mask =
          if game_version == "RoE"
            allowed_factions_roe
          else
            allowed_factions_post_roe
          end

        allowed_factions_mask
      end

      # uint8 :has_main_town

      # uint8  :main_town_has_hero, onlyif: :has_main_town?
      # uint8  :main_town_type,     onlyif: :has_main_town?
      # uint8  :main_town_coord_x,  onlyif: :has_main_town?
      # uint8  :main_town_coord_y,  onlyif: :has_main_town?
      # uint8  :main_town_coord_z,  onlyif: :has_main_town?

      # uint8  :has_random_hero

      # uint8  :first_hero_type
      # uint8  :first_hero_face
      # uint32 :first_hero_name_size
      # string :first_hero_name, read_length: :first_hero_name_size

      # uint8  :unknown_offset, onlyif: :has_heroes?
      # uint32 :heroes_count,   onlyif: :has_heroes?

      # array  :heroes, type: :hero_record, initial_length: :heroes_count

      def main_town?
        main_town.nonzero?
      end

      def heroes?
        first_hero_type != 0xFF
      end
    end

    # Top-level BinData record for map file
    class MapRecord < BinData::Record
      endian :little

      uint32 :game_version_code, check_value: lambda {
        game_version_from_code(value)
      }

      uint8  :map_has_players
      uint32 :map_size
      uint8  :map_has_subterranean

      uint32 :map_name_length
      string :map_name, read_length: :map_name_length

      uint32 :map_desc_length
      string :map_desc, read_length: :map_desc_length

      uint8  :map_difficulty

      # no max_level in RoE maps
      uint8  :max_level, onlyif: -> { game_version != "RoE" }

      array  :players, type: :player_record, initial_length: 8

      def game_version
        game_version_from_code(game_version_code)
      end

      def game_version_from_code(code)
        # Can't use symbols here: bindata considers them to be method names and
        # tries to call it

        # TODO: add HotA code
        case code
        when 0x0E then "RoE"
        when 0x15 then "AB"
        when 0x1C then "SoD"
        when 0x33 then "WoG"
        else
          raise H3m::FormatError, "unknown game version code: #{code}"
        end
      end
    end
  end
end
