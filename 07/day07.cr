struct Vertex
  property name, edges

  def initialize(@name : String)
    @edges = {} of Vertex => Int32
  end

  def add_edge(vertex, weight)
    @edges[vertex] = weight if vertex
  end
end

class Graph
  property vertices

  delegate :[]=, to: @vertices
  delegate :[]?, to: @vertices

  def initialize
    @vertices = {} of String => Vertex
  end

  def add_vertex(name, vertex)
    @vertices[name] ||= vertex
  end

  def get_vertex(name)
    @vertices[name]?
  end

  def sum_weights(vertex)
    vertex.edges.reduce(0) do |memo, (edge, weight)|
      memo + weight + weight * sum_weights(edge)
    end
  end

  def dfs(vertex, expected)
    vertex.edges.find { |edge, _| edge.name == expected || dfs(edge, expected) }
  end
end

graph = Graph.new

File.read_lines("07/input.txt").each do |line|
  parts = line.split
  bag_name = parts[0] + parts[1]
  graph.add_vertex(bag_name, graph.get_vertex(bag_name) || Vertex.new(bag_name))
  parts[4..].reject(&.includes?("bag")).each_slice(3) do |slice|
    next if slice.size != 3
    contained_bag_name = slice[1] + slice[2]
    graph[contained_bag_name] ||= Vertex.new(contained_bag_name)
    graph[bag_name]?.try &.add_edge(graph[contained_bag_name]?, slice[0].to_i)
  end
end

# p1
pp graph.vertices.values.count { |v| graph.dfs(v, "shinygold") }

# p2
pp graph.sum_weights(graph.vertices["shinygold"])
