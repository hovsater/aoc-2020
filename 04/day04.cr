class Day04
  struct Passport
    REQUIRED_PROPERTIES = ["byr", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"]

    property properties

    def initialize(@properties : Hash(String, String))
    end

    def contains_required_properties?
      (REQUIRED_PROPERTIES - properties.keys).empty?
    end

    def valid?
      contains_required_properties? && properties_valid?
    end

    private def properties_valid?
      properties.all? do |prop, value|
        case prop
        when "byr" then (1920..2002).includes?(value.to_i)
        when "iyr" then (2010..2020).includes?(value.to_i)
        when "eyr" then (2020..2030).includes?(value.to_i)
        when "hgt"
          value.ends_with?("cm") && (150..193).includes?(value[0..-3].to_i) ||
            value.ends_with?("in") && (59..76).includes?(value.[0..-3].to_i)
        when "hcl" then value =~ /\A#[0-9a-f]{6}\z/
        when "ecl" then %w(amb blu brn gry grn hzl oth).includes?(value)
        when "pid" then value =~ /\A[0-9]{9}\z/
        when "cid" then true
        else
          false
        end
      end
    end
  end

  def self.part_one
    puts new(File.read_lines("./04/input.txt")).solve_part1
  end

  def self.part_two
    puts new(File.read_lines("./04/input.txt")).solve_part2
  end

  @passports : Array(Passport)

  def initialize(passport_batch_file)
    @passports = passport_batch_file.slice_before("").map { |p|
      keys, values = p.join(" ").strip.split(" ").map(&.split(":")).transpose
      Passport.new(Hash.zip(keys, values))
    }.to_a
  end

  def solve_part1
    @passports.count(&.contains_required_properties?)
  end

  def solve_part2
    @passports.count(&.valid?)
  end
end
