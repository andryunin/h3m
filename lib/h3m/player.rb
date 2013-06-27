module H3m

  class PlayerError < MapError
  end

  class Player
    # Player representation

    COLORS = [:red, :blue, :tan, :green, :orange, :purple, :teal, :pink]
    TOWNS  = [:castle, :rampart, :tower, :inferno, :necropolis,
              :dunegon, :stronghold, :fortress, :conflux]

    attr_reader :record
    attr_reader :number
    attr_reader :color

    def initialize(record, number)
      @record = record
      @number = number
      @color = Player::COLORS[number]
    end

    def human?
      unless [0, 1].include? record.can_be_human
        raise PlayerError.new("unknown value %X for human availability flag" %
                              record.can_be_human)
      end
      record.can_be_human != 0
    end

    def computer?
      unless [0, 1].include? record.can_be_computer
        raise PlayerError.new("unknown value %X for computer availability flag" %
                              record.can_be_computer)

      end
      record.can_be_computer != 0
    end

    def present?
      human? || computer?
    end

    def max_level
      record.max_level
    end

    def computer_behaviour
      @computer_behaviour ||= case record.computer_behaviour
        when 0 then :random
        when 1 then :warrior
        when 2 then :builder
        when 3 then :explorer
        else
          raise PlayerException.new("unknown computer behaviour %X" %
                                    record.computer_behaviour)
      end
    end

    def has_town_on_start?
      record.has_town_on_start != '0'
    end
  end

end