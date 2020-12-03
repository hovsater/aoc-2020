require "spec"
require "./day03"

describe Day03 do
  it "counts trees in the grid given a slope" do
    day3 = Day03.new([
      "..##.......",
      "#...#...#..",
      ".#....#..#.",
      "..#.#...#.#",
      ".#...##..#.",
      "..#.##.....",
      ".#.#.#....#",
      ".#........#",
      "#.##...#...",
      "#...##....#",
      ".#..#...#.#",
    ])

    day3.solve(3, 1).should eq(7)
  end
end
