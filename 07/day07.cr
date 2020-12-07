TEST_INPUT = <<-EOF.split("\n")
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
EOF

struct Vertex
  property name, adjacent_vertices

  def initialize(@name : String)
    @adjacent_vertices = [] of Vertex
  end

  def add_adjacent_vertex(vertex)
    @adjacent_vertices << vertex if vertex
  end
end

class Graph
  property vertices

  def initialize
    @vertices = {} of String => Vertex
  end

  def add_vertex(name, vertex)
    @vertices[name] ||= vertex
  end

  def get_vertex(name)
    @vertices[name]?
  end

  def dfs(vertex, name, visisted_verticies = {} of String => Bool)
    return vertex if vertex.name == name

    visisted_verticies[vertex.name] = true

    vertex.adjacent_vertices.each do |adjacent_vertex|
      next if visisted_verticies[adjacent_vertex.name]?
      return adjacent_vertex if adjacent_vertex.name == name

      found_vertex = dfs(adjacent_vertex, name, visisted_verticies)
      return found_vertex if found_vertex
    end
  end
end

graph = Graph.new

File.read_lines("07/input.txt").each do |line|
  parts = line.split
  bag_name = parts[0] + parts[1]
  graph.add_vertex(bag_name, graph.get_vertex(bag_name) || Vertex.new(bag_name))
  parts[4..].reject(&.includes?("bag")).each_slice(3) do |slice|
    next if slice.size < 3
    adjacent_bag_name = slice[1..].join
    graph.add_vertex(adjacent_bag_name, graph.get_vertex(adjacent_bag_name) || Vertex.new(adjacent_bag_name))
    graph.get_vertex(bag_name).try &.add_adjacent_vertex(graph.get_vertex(adjacent_bag_name))
  end
end

# p1
pp graph.vertices.values.count { |v| graph.dfs(v, "shinygold") } - 1
