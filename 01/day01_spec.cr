require "spec"
require "./day01"

describe Day01 do
  it "multiplies two numbers that sum to 2020" do
    day1 = Day01.new([1721, 979, 366, 299, 675, 1456])
    day1.solve.should eq(514579)
  end

  it "multiplies given size of numbers that sum to 2020" do
    day1 = Day01.new([1721, 979, 366, 299, 675, 1456], combination_size: 3)
    day1.solve.should eq(241861950)
  end
end
