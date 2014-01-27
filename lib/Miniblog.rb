require "tilt"
require "haml"
require "pathname"


require "Miniblog/front_matter"
require "Miniblog/renderer"

require "Miniblog/generator"
require "Miniblog/generators/layout"
require "Miniblog/generators/page"

require "Miniblog/site_singleton"

require "Miniblog/template"
require "Miniblog/layout"
require "Miniblog/page"

require "Miniblog/version"


module Miniblog
  Site = Miniblog::SiteSingleton.instance
end
