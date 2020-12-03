class Day03
  @rows : Int32
  @cols : Int32

  def self.part_one
    puts new(File.read_lines("./03/input.txt")).solve(3, 1)
  end

  def self.part_two
    day3 = new(File.read_lines("./03/input.txt"))
    puts [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
      .product(1_u64) { |right, down| day3.solve(right, down) }
  end

  def initialize(@layout : Array(String))
    @rows = @layout.size
    @cols = @layout[0].size
  end

  def solve(right, down)
    x = 0
    (down...@rows).step(down).count do |y|
      x += right
      @layout[y][x % @cols] == '#'
    end
  end
end
