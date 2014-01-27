module Miniblog
  class Renderer
    def initialize(renderable)
      @renderable = renderable
    end

    def content
      content = @renderable.render(params)
      current = @renderable

      while current.parent?
        current = Miniblog::Site.generator(:layout).layout(current.parent)
        content = current.render(params, content)
      end

      content
    end

    def params
      return @params if @params

      current = @renderable
      @params = current.yaml.clone

      loop do
        @params.merge! current.yaml

        if current.parent?
          current = Miniblog::Site.generator(:layout).layout(current.parent)
        else
          break
        end
      end

      @params.delete 'layout'
      @params
    end
  end
end
