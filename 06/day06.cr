puts File.read_lines("./06/input.txt").slice_before("").sum(&.join.chars.uniq.size)
puts File.read_lines("./06/input.txt").slice_before("").sum { |l| l.join.chars.tally.values.count(l[0] == "" ? l.size - 1 : l) }
