puts File.read_lines("./06/input.txt").slice_before("").sum(&.join.chars.uniq.size)
puts File.read_lines("./06/input.txt").slice_before("").sum { |l| (l - [""]).map(&.chars).reduce { |a, b| a & b }.size }
