def part1(input, preamble)
  input.reverse_each.each_cons(preamble + 1, reuse: true) do |a|
    a[1..].combinations(2).map(&.sum).includes?(a[0]) || return a[0]
  end
end

def part2(input, preamble)
  target = part1(input, preamble) || 0

  input.each_index do |i|
    sum = 0
    nums = input[i..].take_while do |n|
      sum += n
      sum < target
    end

    return nums.minmax.sum if sum == target
  end
end

input = File.read_lines("./09/input.txt").map(&.to_u64)
puts part1(input, 25)
puts part2(input, 25)
