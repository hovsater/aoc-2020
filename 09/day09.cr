def part1(input, preamble)
  input.reverse_each.each_cons(preamble + 1, reuse: true) do |e|
    e[1..].combinations(2).any? { |(a, b)| a + b == e[0] } || return e[0]
  end
end

def part2(input, preamble)
  target = part1(input, preamble) || 0
  input.each_index do |i|
    sum = 0
    seq = input[i..].take_while { |n| (sum += n) < target }
    return seq.minmax.sum if sum == target
  end
end

input = File.read_lines("./09/input.txt").map(&.to_u64)
puts part1(input, 25)
puts part2(input, 25)
