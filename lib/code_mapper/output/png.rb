require 'ruby-graphviz'

module CodeMapper
  module Output
    class Png
      def initialize(io)
        @io = io
        @stack = []

        @graph = GraphViz.new(:G, type: :digraph)
      end

      def push(tp, normalized_class_name)
        node = @graph.add_nodes("#{normalized_class_name}.#{tp.method_id.to_s}")

        if @stack != []
          @graph.add_edges(@stack.last, node)
        end

        @stack << node
      end

      def pop(tp, normalized_class_name)
        @stack.pop
      end

      def done
        @graph.output(png: @io)
      end
    end
  end
end
