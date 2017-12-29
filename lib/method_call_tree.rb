require 'method_call_tree/version'

class MethodCallTree
  GET_ARGUMENTS = <<-'TEXT'.freeze
    method(__method__).parameters.map { |_t, v|
      "#{v} = #{eval(v.to_s).inspect}"
    }.join(', ')
  TEXT

  SPACE_SIZE = 8
  T_LINE = '├─────'.freeze
  I_LINE = '│'.freeze
  L_LINE = '└─────'.freeze

  def self.create(options = {}, &block)
    new(options, &block)
  end

  def initialize(options)
    @args = options[:args]
    @tree = {}
    @queue = []

    tracer.enable { yield }

    @tree.each do |root, tree|
      walk(root, tree)
    end
  end

  def to_s
    @queue.join
  end

  private

  def tracer
    id = 0
    call_stack = []

    TracePoint.new(:call, :return) do |tp|
      case tp.event
        when :call
          key = "#{tp.defined_class}::#{tp.method_id}"
          key += "(#{tp.binding.eval(GET_ARGUMENTS)})" if @args
          key += "_#{id}"
          id += 1

          call_stack.inject(@tree, :[])[key] = {}
          call_stack.push(key)
        when :return
          call_stack.pop
      end
    end
  end

  def get_line(end_line:, space:)
    end_line ? "#{space}#{L_LINE} " : "#{space}#{T_LINE} "
  end

  def get_space(end_line:)
    end_line ? ' ' * SPACE_SIZE : I_LINE + ' ' * (SPACE_SIZE - 1)
  end

  def walk(parent, tree, space = "")
    @queue << "#{parent.gsub(/_\d+$/, '')}\n"

    while node = tree.shift
      @queue << get_line(end_line: tree.empty?, space: space)
      walk(*node, space + get_space(end_line: tree.empty?))
    end
  end
end
