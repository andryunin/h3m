# frozen_string_literal: true

module H3m
  class PlayerError < MapError
  end

  class Player
    # Player representation

    COLORS = %i[red blue tan green orange purple teal pink].freeze

    FACTIONS = %i[
      castle rampart tower inferno necropolis
      dunegon stronghold fortress conflux
    ].freeze

    attr_reader :record
    attr_reader :number
    attr_reader :color

    def initialize(record, number)
      @record = record
      @number = number
      @color = Player::COLORS[number]
    end

    def can_be_human?
      record.can_be_human != 0
    end

    def can_be_ai?
      record.can_be_ai != 0
    end

    def present?
      can_be_human? || can_be_ai?
    end

    def max_level
      record.max_level
    end

    def ai_behaviour
      case record.ai_behaviour
      when 0 then :random
      when 1 then :warrior
      when 2 then :builder
      when 3 then :explorer
      else
        raise FormatError, "unknown ai behaviour: #{record.ai_behaviour}"
      end
    end
  end
end
