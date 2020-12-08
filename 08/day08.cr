def exec(program)
  pc = acc = 0
  seen = Set(Int32).new

  while pc < program.size
    op, count = program[pc]

    return {:aborted, acc} if seen.includes?(pc)
    seen.add(pc)

    case op
    when "acc"
      acc += count
      pc += 1
    when "jmp"
      pc += count
    when "nop"
      pc += 1
    end
  end

  {:done, acc}
end

def flip(instruction)
  op, count = instruction
  case op
  when "jmp" then {"nop", count}
  when "nop" then {"jmp", count}
  else            instruction
  end
end

def exec_fix(program)
  pool = [] of Int32
  prev = -1

  program.each_with_index do |(op, _), index|
    pool << index if op == "jmp" || op == "nop"
  end

  status, acc = exec(program)
  while status == :aborted
    program[prev] = flip(program[prev]) if prev != -1
    prev = pool.pop
    program[prev] = flip(program[prev])
    status, acc = exec(program)
  end

  {status, acc}
end

def parse(instructions)
  instructions.map do |instruction|
    parts = instruction.split
    {parts[0], parts[1].to_i}
  end
end

input = File.read_lines("./08/input.txt")

# p1
pp exec(parse(input)).last
# p2
pp exec_fix(parse(input)).last
