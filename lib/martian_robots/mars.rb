module MartianRobots
  class Mars

    attr_reader :limits, :forbidden_positions, :x_limit, :y_limit

    MAX_COORD_LENGTH = 50

    def initialize(args)
      raise "A grid cant exceel a value of 50" if args[:limits].max > MAX_COORD_LENGTH 
      @limits  = args[:limits]
      @x_limit = args[:limits].first
      @y_limit = args[:limits].last
    end
  end
end