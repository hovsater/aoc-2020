def part1(input, preamble)
  input.reverse_each.each_cons(preamble + 1, reuse: true) do |e|
    e[1..].combinations(2).any? { |(a, b)| a + b == e[0] } || return e[0]
  end
end

def part2(input, preamble)
  target = part1(input, preamble) || 0

  s = e = 0
  sum = input[s]

  loop do
    if sum < target
      e += 1
      sum += input[e]
    elsif sum > target
      sum -= input[s]
      s += 1
    else
      return input[s..(e + 1)].minmax.sum
    end
  end
end

input = File.read_lines("./09/input.txt").map(&.to_u64)
puts part1(input, 25)
puts part2(input, 25)
