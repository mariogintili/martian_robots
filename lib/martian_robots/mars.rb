module MartianRobots
  class Mars

    attr_reader :limit, :forbidden_coordinates

    MAX_COORD_LENGTH = 50

    def initialize(args)
      raise "A grid cant exceel a value of 50" if args[:coordinates].max > 50
      @limit = args[:coordinates].inject(:*)
    end
  end
end