require 'spec_helper'

describe Miniblog::Template do
  let(:contents) { ".test\n  =yield" }
  let(:yaml_contents) { "---\ntitle: Test\n---\n.test\n  =yield" }
  let(:layout_contents) { "---\nlayout: post\n---\n.test\n  =yield" }

  class Page < Miniblog::Template
  end

  describe '#new' do
    context 'with yaml' do
      it 'assigns content' do
        page = Page.new(yaml_contents)
        expect(page.content).to eq(".test\n  =yield")
      end

      it 'assigns yaml' do
        page = Page.new(yaml_contents)
        expect(page.yaml).to eq({ 'title' => 'Test' })
      end
    end

    context 'without yaml' do
      it 'assigns content' do
        page = Page.new(contents)
        expect(page.content).to eq(".test\n  =yield")
      end

      it 'assigns yaml to empty hash' do
        page = Page.new(contents)
        expect(page.yaml).to eq({})
      end
    end
  end

  describe '#render' do
    it 'renders content' do
      page = Page.new(layout_contents)

      expected = %Q[<div class='test'>\n  test\n</div>\n]

      expect(page.render({}, 'test')).to eq(expected)
    end
  end
end
