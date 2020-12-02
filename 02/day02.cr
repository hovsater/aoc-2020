class Day02
  POLICY_REGEX = /\A(?<min>\d+)-(?<max>\d+) (?<letter>[a-z]): (?<password>[a-z]+)\z/

  def self.part_one
    puts Day02.new(File.read_lines("./02/input.txt")).solve_part1
  end

  def self.part_two
    puts Day02.new(File.read_lines("./02/input.txt")).solve_part2
  end

  def initialize(@password_policies : Array(String))
  end

  def solve_part1
    @password_policies.count do |policy|
      m = policy.match(POLICY_REGEX).not_nil!
      (m["min"].to_i..m["max"].to_i).includes?(m["password"].count(m["letter"]))
    end
  end

  def solve_part2
    @password_policies.count do |policy|
      m = policy.match(POLICY_REGEX).not_nil!
      (m["password"][m["min"].to_i - 1] == m["letter"][0]) ^ (m["password"][m["max"].to_i - 1] == m["letter"][0])
    end
  end
end
