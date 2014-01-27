module Miniblog
  class Page < Template
    def initialize(content, path)
      super(content)
      @path = Pathname.new(path)
    end

    def path
      pwd = Pathname.new(Dir.pwd)
      path = @path.relative_path_from(pwd)
      "#{path.dirname}/#{path.basename ".markdown"}"
    end

    def file_name
      extension = File.extname(@path.to_s)
      File.basename(@path.to_s, extension)
    end
  end
end
