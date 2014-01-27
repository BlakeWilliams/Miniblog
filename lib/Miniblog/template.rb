module Miniblog
  class Template
    include FrontMatter

    attr_reader :content, :yaml

    def initialize(content)
      @content = parse_content(content)
      @yaml = parse_yaml(content)
    end

    def render(params, content = nil)
      template = Tilt::HamlTemplate.new { @content }

      if content
        template.render(self, params) { content }
      else
        template.render(self, params)
      end
    end

    def parent
      @yaml['layout']
    end

    def parent?
      @yaml['layout'] != nil
    end
  end

end
