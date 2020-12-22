TEST_INPUT = File.read("#{__DIR__}/test.txt")
REAL_INPUT = File.read("#{__DIR__}/real.txt")

enum Direction
  NORTH =   0
  EAST  =  90
  SOUTH = 180
  WEST  = 270
end

def parse(instructions)
  direction = Direction::EAST
  x, y = {0, 0}

  instructions.scan(/([A-Z])(\d+)/).each do |(_, action, value)|
    case action
    when "N" then y += value.to_i
    when "S" then y -= value.to_i
    when "E" then x += value.to_i
    when "W" then x -= value.to_i
    when "L" then direction = Direction.new((direction.value - value.to_i + 360) % 360)
    when "R" then direction = Direction.new((direction.value + value.to_i + 360) % 360)
    when "F"
      case direction
      when Direction::NORTH then y += value.to_i
      when Direction::SOUTH then y -= value.to_i
      when Direction::EAST  then x += value.to_i
      when Direction::WEST  then x -= value.to_i
      end
    end
  end

  x.abs + y.abs
end

def rotate(point, degrees)
  x, y = point
  radians = degrees * (Math::PI / 180)

  nx = (x * Math.cos(radians) - y * Math.sin(radians)).round.to_i
  ny = (x * Math.sin(radians) + y * Math.cos(radians)).round.to_i

  {nx, ny}
end

def parse_with_waypoint(instructions)
  ox, oy = 0, 0
  px, py = 10, 1

  instructions.scan(/([A-Z])(\d+)/).each do |(_, action, value)|
    case action
    when "N" then py += value.to_i
    when "S" then py -= value.to_i
    when "E" then px += value.to_i
    when "W" then px -= value.to_i
    when "L" then px, py = rotate({px, py}, degrees: value.to_i)
    when "R" then px, py = rotate({px, py}, degrees: -value.to_i)
    when "F"
      ox = ox + (px * value.to_i)
      oy = oy + (py * value.to_i)
    end
  end

  ox.abs + oy.abs
end

def part_1
  puts parse(REAL_INPUT)
end

def part_2
  puts parse_with_waypoint(REAL_INPUT)
end

part_1
part_2
