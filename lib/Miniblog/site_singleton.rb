require "singleton"

module Miniblog
  class SiteSingleton
    include Singleton

    DEFAULT_GENERATORS = {
      layout: Miniblog::Generators::Layout,
      page: Miniblog::Generators::Page
    }

    attr_reader :generators

    def initialize
      @generators = {}

      DEFAULT_GENERATORS.each do |name, generator|
        add_generator(name, generator)
      end
    end

    def add_generator(name, generator_class)
      @generators[name.to_sym] = generator_class.new(self)
    end

    def remove_generator(name)
      @generators.delete name.to_sym
    end

    def generator(name)
      @generators[name.to_sym]
    end

    def generate_all
      @generators.values.each do |generator|
        generator.generate(self)
      end
    end

    def write_all
    end

    def reset 
      @generators.values.each do |generator|
        generator.reset(self)
      end
    end
  end
end
