module Miniblog
  module Generators
    class Page < Miniblog::Generator
      PATH = './pages'

      attr_reader :pages

      def initialize(site)
        reset
      end

      def reset
        @pages = []
      end

      def generate(site)
        reset

        entries.each do |entry|
          contents = File.read(entry)
          @pages << Miniblog::Page.new(contents, entry)
        end
      end

      def write(site)
        @pages.each do |page|
          renderer = Miniblog::Renderer.new(page)

          #Dir.mkdir(page.path)
          #File.write(renderer.content)
        end
      end

      private

      def entries
        entries = Dir.entries(PATH)
        entries.select { |entry| entry.match(/\.(md|markdown)$/) }
      end

    end
  end
end
