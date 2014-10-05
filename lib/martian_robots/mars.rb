module MartianRobots
  class Mars

    attr_reader :grid, :forbidden_coordinates

    MAX_COORD_LENGTH = 50

    def initialize(args)
      @grid = build_grid args[:coordinates]
    end

    def forbidden_coordinates
      @forbidden_coordinates ||= []
    end

    def upgrade_location(robot)
      new_coords = robot.next_coordinate
      if off_edge?(new_coords)
        if forbidden_coordinates.any? { |x| x[:coordinates] == robot.coordinates }
          robot.move false
        else
          mark_lost(robot)
        end
      else
        robot.move
        set(robot)
      end
    end

    def valid?(coords)
      valid_x = grid.transpose.length >= coords.first
      valid_y = grid.length >= coords.last
      valid_x && valid_y 
    end

    def safe_area?(coords)
      find_by_coordinate(coords) != forbidden
    end

    def off_edge?(coords)
      !valid?(coords)
    end

    def find_by_coordinate(coordinates)
      grid[coordinates[0]][coordinates[1]] rescue nil
    end

    def coordinates_for(element)      
      x = grid.find_index { |row| row.include? element }
      y = grid.transpose.find_index { |row| row.include? element }
      return if [x,y].any? { |a| a.nil? }
      [x, y] 
    end

    def set(robot)
      old_coordinates = coordinates_for(robot)
      delete_by_coordinate(old_coordinates)
      insert(robot.coordinates, robot)
    end

    def find(element)
      grid.find(-> {[]}) { |row| row.include? element }.find { |a| a == element }
    end

    def insert(coords, value)
      set_value(coords, value)
    end

    private

    def mark_lost(robot)

      found_robot = find(robot)
      found_robot.vanish
      delete_by_coordinate(found_robot.coordinates)
      forbidden_coordinates.push({coordinates: found_robot.coordinates, direction: found_robot.direction})
    end

    def delete_by_coordinate(coords)
      set_value(coords, nil)
    end

    def x_limit
      grid.length
    end

    def y_limit
      grid.transpose.length
    end

    def substract_if_limit(coords)
      x = coords[0] - 1 if coords[0] >= x_limit
      y = coords[1] - 1 if coords[1] >= y_limit
      [x || coords[0], y || coords[1]] 
    end

    def set_value(coords, value)
      coordinates = substract_if_limit(coords)
      grid[coordinates[0]][coordinates[1]] = value
    end

    def build_grid(coordinates)
      raise "A grid cant exceel a value of 50" if coordinates.max > 50
      x, y = coordinates.first, coordinates.last
      Array.new(y) { Array.new(x) }
    end
  end
end