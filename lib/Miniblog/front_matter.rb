require 'yaml'

module Miniblog
  module FrontMatter
    SPLIT_REGEX = /^---\n/

    private

    def parse_content(content)
      if has_yaml? content
        content.split(SPLIT_REGEX)[2]
      else
        content
      end
    end

    def parse_yaml(content)
      if has_yaml? content
        YAML.load(content.split(SPLIT_REGEX)[1])
      else
        {}
      end
    end

    def has_yaml?(content)
      content.match(SPLIT_REGEX)
    end
  end
end
