REAL_INPUT = File.read_lines("#{__DIR__}/real.txt")
TEST_INPUT = File.read_lines("#{__DIR__}/test.txt")

def part_1(input)
  estimate = input.first.to_i
  buss_ids = input.last.split(",").reject(&.==("x")).map(&.to_i)
  puts buss_ids.map { |id| {id, id - estimate % id} }.min_by(&.[1]).product
end

def part_2(input)
  busses = input.last.split(",")
  time = 0_u64
  multiplier = 1_u64

  busses.each_with_index do |id, offset|
    next if id == "x"

    while (time + offset) % id.to_i != 0
      time += multiplier
    end

    multiplier *= id.to_i
  end

  puts time
end

part_1(REAL_INPUT)
part_2(REAL_INPUT)
