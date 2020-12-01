class Day01
  def self.part_one
    puts new(File.read_lines("./01/input.txt").map(&.to_i)).solve
  end

  def self.part_two
    puts new(File.read_lines("./01/input.txt").map(&.to_i), combination_size: 3).solve
  end

  def initialize(@numbers : Array(Int32), @combination_size = 2)
  end

  def solve
    @numbers
      .combinations(@combination_size)
      .find { |numbers| numbers.sum == 2020 }
      .not_nil!
      .product
  end
end
