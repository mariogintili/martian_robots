module MartianRobots
  class Robot

    attr_accessor :instructions, :coordinates, :direction, :lost

    COMPASS = { "N" => "E", "E" => "S", "S" => "W", "W" => "N" }

    MOVES = { "R" => COMPASS, "L" => COMPASS.invert }

    def initialize(args)
      options       = build_args args
      @instructions = options[:instructions]
      @coordinates  = options[:coordinates]
      @direction    = options[:direction]
    end

    def lost?
      !!lost
    end

    def safe?
      !lost
    end

    def vanish
      self.lost = true
    end

    def next_coordinate
      action = instructions.first
      action == "F" ? move_position[direction].call : coordinates
    end

    def move(opts = {:allow_forward => true})
      action = instructions.shift
      if action == "F"
        if opts[:allow_forward]
          self.coordinates = move_position[direction].call
        end
      else
        self.direction  = MOVES[action][direction]
      end
    end

    def position
      message = coordinates.join(' ') + " #{direction}"
      lost? ? message + " LOST" : message
    end

    private

    def move_position
      {
        "N" => -> { [coordinates[0], coordinates[1] + 1] },
        "S" => -> { [coordinates[0], coordinates[1] - 1] },
        "E" => -> { [coordinates[0] + 1, coordinates[1]] },
        "W" => -> { [coordinates[0] - 1, coordinates[1]] },
      }
    end

    def build_args(args)
      position = args[:position].split(' ')
      {
        direction: position.last,
        coordinates: position.take(2).map(&:to_i),
        instructions: args[:instructions].chars,
      }
    end
  end
end