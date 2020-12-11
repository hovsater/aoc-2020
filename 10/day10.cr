TEST_INPUT = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
REAL_INPUT = File.read_lines("#{__DIR__}/input.txt").map(&.to_i)

def part_1(input)
  sorted = input.sort

  ([0] + sorted + [sorted.last + 3]).each_cons(2, reuse: true)
    .map { |(a, b)| b - a }.tally.values.product
end

def part_2(input)
  sorted = input.sort

  paths = Hash(Int32, UInt64).new(0)
  paths[0] = 1

  ([0] + sorted).each do |n|
    (1..3).each { |d| paths[n + d] += paths[n] if sorted.includes?(n + d) }
  end

  paths[sorted.last]
end

puts part_1(REAL_INPUT)
puts part_2(REAL_INPUT)
