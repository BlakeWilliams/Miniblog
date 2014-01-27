module Miniblog
  module Generators
    class Layout < Miniblog::Generator
      PATH = './layouts'

      attr_reader :layouts

      def initialize(site)
        @layouts = {}
      end

      def generate(site)
        entries.each do |entry|
          base_name = File.basename(entry, '.haml')
          contents = File.read(entry)

          @layouts[base_name.to_sym] = Miniblog::Layout.new(contents)
        end
      end

      def layout(name)
        @layouts[name.to_sym]
      end

      private

      def entries
        entries = Dir.entries(PATH)
        entries.select { |entry| entry.match(/\.haml$/) }
      end

    end
  end
end
