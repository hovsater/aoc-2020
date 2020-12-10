TEST_INPUT = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
REAL_INPUT = File.read_lines("#{__DIR__}/input.txt").map(&.to_i)

def part_1(input)
  sorted = input.sort
  ([0] + sorted + [sorted.last + 3]).each_cons(2, reuse: true).map { |(a, b)| b - a }.tally.values.product
end

puts part_1(REAL_INPUT)
