require "code_mapper/version"
require "code_mapper/tracer"
require "code_mapper/filter/start_at"
require "code_mapper/filter/callee"
require "code_mapper/filter/max_depth"
require "code_mapper/filter/project_root"
require "code_mapper/output/text"
require "code_mapper/output/dot"
require "code_mapper/output/png"

module CodeMapper
  def self.trace(filter: nil, start_at: nil, max_depth: nil, project_root: nil, output: CodeMapper::Output::Text.new($stdout), &block)
    filters = []
    filters << Filter::Callee.new(filter) if filter
    filters << Filter::StartAt.new(start_at) if start_at
    filters << Filter::MaxDepth.new(max_depth) if max_depth
    filters << Filter::ProjectRoot.new(project_root) if project_root

    tracer = Tracer.new(filters: filters, output: output)
    tracer.enable

    begin
      yield
    ensure
      tracer.disable
    end
  end
end
