class Day05
  def self.part_one
    puts new(File.read_lines("./05/input.txt")).solve_part1
  end

  def self.part_two
    puts new(File.read_lines("./05/input.txt")).solve_part2
  end

  @seat_ids : Array(Int32)

  property seat_ids

  def initialize(boarding_passes)
    @seat_ids = boarding_passes.map { |b| b.tr("FBLR", "0101").to_i(2) }
  end

  def solve_part1
    @seat_ids.max
  end

  def solve_part2
    ((@seat_ids.min..@seat_ids.max).to_a - @seat_ids).first
  end
end
