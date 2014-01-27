module Miniblog
  class Generator
    def initialize(site)
    end

    def generate(site)
      raise NotImplementedError, 
        "You must implement a generate method"
    end

    def reset(site)
      raise NotImplementedError, 
        "You must implement a generate method"
    end
    
    def write(site)
    end
  end
end
