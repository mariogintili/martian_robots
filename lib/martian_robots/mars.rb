module MartianRobots
  class Mars

    attr_reader :limits, :forbidden_positions

    MAX_COORD_LENGTH = 50

    def initialize(args)
      raise "A grid cant exceel a value of 50" if args[:limits].max > MAX_COORD_LENGTH 
      @limits  = args[:limits]
    end

    def x_limit
      limits.first 
    end

    def y_limit
      limits.last
    end

    def in?(coords)
      return false if coords.any? { |x|  0 > x }
      x, y = coords
      (x_limit >= x) && (y_limit >= y)
    end
  end
end