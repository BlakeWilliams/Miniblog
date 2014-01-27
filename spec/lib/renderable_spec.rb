require 'spec_helper'

describe Miniblog::Renderer do
  let(:site) { Miniblog::Site }
  let(:layout_generator) { Miniblog::Generators::Layout.new(site) }
  let(:page_content) { "---\ntitle: Test Title\nlayout: page\n---\nContent" }
  let(:page) { Miniblog::Page.new(page_content, "/site/pages/test.md") }
  let(:page_layout) { Miniblog::Layout.new("---\nlayout: default\n---\n.header\n  =yield") }
  let(:default_layout) { Miniblog::Layout.new("---\nlayer: 3\n---\n%html\n  =yield") }

  before do
    allow(site).to receive(:generator).with(:layout) do
      layout_generator
    end

    allow(layout_generator).to receive(:layout).with('page') do
      page_layout
    end

    allow(layout_generator).to receive(:layout).with('default') do
      default_layout 
    end
  end

  describe 'content' do
    it 'renders the nested content' do
      renderer = Miniblog::Renderer.new(page)

      expect(renderer.content).to eq("<html>\n  <div class='header'>\n    Content\n  </div>\n</html>\n")
    end
  end

  describe 'params' do
    it 'has params from all levels' do
      renderer = Miniblog::Renderer.new(page)
      expect(renderer.params).to eq({
        "layer" => 3,
        "title" => "Test Title"
      })
    end
  end
end
