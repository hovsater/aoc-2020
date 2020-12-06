puts File.read("./06/input.txt").split("\n\n").sum(&.split("\n").join.chars.uniq.size)
puts File.read("./06/input.txt").split("\n\n").sum { |l| l.split("\n").map(&.chars).reduce { |a, b| a & b }.size }
