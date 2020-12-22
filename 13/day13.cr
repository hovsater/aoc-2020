REAL_INPUT = File.read_lines("#{__DIR__}/real.txt")
TEST_INPUT = File.read_lines("#{__DIR__}/test.txt")

def parse(input)
  estimate = input.first.to_i
  buss_ids = input.last.split(",").reject(&.==("x")).map(&.to_i)
  buss_ids.map { |id| {id, id - estimate % id} }.min_by(&.[1]).product
end

puts parse(REAL_INPUT)
