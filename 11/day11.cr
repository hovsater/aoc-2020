TEST_INPUT = <<-EOF
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
EOF
REAL_INPUT = File.read("#{__DIR__}/input.txt").chomp

alias Board = NamedTuple(grid: Array(Array(Char)), width: Int32, height: Int32)
alias Rule = Board, Tuple(Int32, Int32), Tuple(Int32, Int32) -> Bool

def board_from_layout(layout)
  grid = layout.split("\n").map(&.chars)
  Board.new(grid: grid, width: grid.first.size, height: grid.size)
end

def iterate(board, threshold, &block : Rule)
  directions = [[-1, 0], [1, 0], [1, 1], [1, -1], [-1, -1], [-1, 1], [0, 1], [0, -1]]
  board[:grid].each_with_index.each_with_object(board.clone) do |(row, y), new_board|
    row.each_with_index do |col, x|
      occupied = directions.count { |(dx, dy)| yield board, {x, y}, {dx, dy} }
      new_board[:grid][y][x] =
        if col == 'L' && occupied == 0
          '#'
        elsif col == '#' && occupied >= threshold
          'L'
        else
          col
        end
    end
  end
end

def part_1
  board = board_from_layout(REAL_INPUT)
  rule = Rule.new do |b, (x, y), (dx, dy)|
    0 <= x + dx < b[:width] && 0 <= y + dy < b[:height] && b[:grid][y + dy][x + dx] == '#'
  end

  while (new_board = iterate(board, threshold: 4, &rule)) != board
    board = new_board
  end

  puts board[:grid].sum(&.count(&.==('#')))
end

def part_2
  board = board_from_layout(REAL_INPUT)
  rule = Rule.new do |b, (x, y), (dx, dy)|
    while 0 <= x + dx < b[:width] && 0 <= y + dy < b[:height]
      return b[:grid][y + dy][x + dx] == '#' if b[:grid][y + dy][x + dx] != '.'
      x += dx
      y += dy
    end

    false
  end

  while (new_board = iterate(board, threshold: 5, &rule)) != board
    board = new_board
  end

  puts board[:grid].sum(&.count(&.==('#')))
end

part_1
part_2
