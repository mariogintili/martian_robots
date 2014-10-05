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
      rotations       = instructions.first.chars
      new_direction   = next_direction(rotations)
      change_position[new_direction].call
    end

    def move
      rotations        = instructions.shift.chars
      self.direction   = next_direction(rotations)
      self.coordinates = change_position[direction].call
    end

    def position
      message = coordinates.join(' ') + " #{direction}"
      lost? ? message + " LOST" : message
    end

    def ignore!
      rotations         = instructions.join.chars
      self.instructions = []
      self.direction    = next_direction(rotations)
    end

    private

    def next_direction(rotations)
      rotations.inject(direction) { |instruction, memo| MOVES[memo][instruction] }
    end

    def change_position
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
        instructions: args[:instructions].split("F"),
      }
    end
  end
end