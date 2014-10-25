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

    def state
      { coordinates: coordinates, direction: direction }
    end

    def move_on(surface)
      if surface.in?(next_coordinate)
        move!
      elsif !surface.allowed?(state)
        instructions.shift
        move!
      else
        drop_scent surface 
      end
    end

    def next_coordinate
      action = instructions.first
      action == "F" ? move_position[direction] : coordinates
    end


    def position
      message = coordinates.join(' ') + " #{direction}"
      lost? ? message + " LOST" : message
    end

    private

    def move!
      next_is_forward? ? forward! : cruise!
      instructions.shift
    end

    def drop_scent(surface)
      vanish
      surface.set_forbbiden_state state
      instructions.shift
    end

    def next_is_forward?
      instructions.first == "F"
    end

    def cruise!
      self.direction = MOVES[instructions.first][direction]
    end

    def forward!
      self.coordinates = move_position[direction]
    end

    def move_position
      {
        "N" => [coordinates[0], coordinates[1] + 1],
        "S" => [coordinates[0], coordinates[1] - 1],
        "E" => [coordinates[0] + 1, coordinates[1]],
        "W" => [coordinates[0] - 1, coordinates[1]],
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
