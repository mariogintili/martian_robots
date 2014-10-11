module MartianRobots
  class Mars

    attr_accessor :limits, :forbidden_states

    MAX_COORD_LENGTH = 50

    def initialize(args)
      raise "A grid cant exceel a value of 50" if args[:limits].max > MAX_COORD_LENGTH 
      @limits  = args[:limits]
    end

    def forbidden_states
      @forbidden_states ||= []
    end

    def x_limit
      limits.first 
    end

    def y_limit
      limits.last
    end

    def set_forbbiden_state(state)
      forbidden_states.push state
    end

    def in?(coords)
      unless coords.any? { |n|  0 > n }
        x, y = coords
        (x_limit >= x) && (y_limit >= y)
      end
    end
  end
end