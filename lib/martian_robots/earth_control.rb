module MartianRobots
  class EarthControl

    attr_reader :mars, :robots

    def initialize(args)
      options = interpret_input args[:input]

      @mars   = options[:mars]
      @robots = options[:robots]
    end

    def execute!
      robots.each do |robot|
        while robot.instructions.any? && robot.safe?
          robot.move_on mars
        end
      end
    end

    def output
      robots.map(&:position).join("\n")
    end

    private

    def interpret_input(input)
      input = input.split(/\n/)
      { mars: build_mars(input), robots: build_robots(input) }
    end

    def build_mars(input)
      Mars.new limits: input.shift.split("").map(&:to_i)
    end

    def build_robots(input)
      input.map do |data|
        info = data.split
        Robot.new position: info.first.split(//).join(' '), instructions: info.last
      end
    end
  end
end