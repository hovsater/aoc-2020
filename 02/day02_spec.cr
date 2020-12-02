require "spec"
require "./day02"

describe Day02 do
  describe "#solve_part1" do
    it "returns number of valid passwords given a password policy list" do
      password_policy_list = [
        "1-3 a: abcde",
        "1-3 b: cdefg",
        "2-9 c: ccccccccc",
      ]

      solver = Day02.new(password_policy_list)
      solver.solve_part1.should eq(2)
    end
  end

  describe "#solve_part2" do
    it "returns number of valid passwords given a password policy list" do
      password_policy_list = [
        "1-3 a: abcde",
        "1-3 b: cdefg",
        "2-9 c: ccccccccc",
      ]

      solver = Day02.new(password_policy_list)
      solver.solve_part2.should eq(1)
    end
  end
end
