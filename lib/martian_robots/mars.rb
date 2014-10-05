module MartianRobots
  class Mars

    attr_reader :grid, :forbidden_coordinates

    MAX_COORD_LENGTH = 50

    def initialize(args)
      @grid = build_grid args[:coordinates]
    end

    private

    def build_grid(coordinates)
      raise "A grid cant exceel a value of 50" if coordinates.max > 50
      x, y = coordinates.first, coordinates.last
      Array.new(y) { Array.new(x) }
    end
  end
end