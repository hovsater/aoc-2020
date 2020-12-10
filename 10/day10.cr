TEST_INPUT = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
REAL_INPUT = File.read_lines("#{__DIR__}/input.txt").map(&.to_i)

def part_1
  differences = Hash(Int32, Int32).new(0)
  differences[3] += 1

  REAL_INPUT.sort.reduce(0) do |jolts, adapter|
    diff = adapter - jolts
    differences[diff] += 1
    adapter
  end

  differences.values.product
end

puts part_1
