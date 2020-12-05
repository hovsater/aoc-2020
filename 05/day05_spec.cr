require "spec"
require "./day05"

describe Day05 do
  it "calculates seat ids given a list of boarding passes" do
    day05 = Day05.new([
      "FBFBBFFRLR",
      "BFFFBBFRRR",
      "FFFBBBFRRR",
      "BBFFBBFRLL",
    ])

    day05.seat_ids.should eq([357, 567, 119, 820])
  end
end
