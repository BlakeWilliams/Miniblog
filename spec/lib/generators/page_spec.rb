require 'spec_helper'

describe Miniblog::Generators::Page do
  let(:site) { double('site') }
  let(:generator) { Miniblog::Generators::Page.new(site) }

  describe '#pages' do
    it 'is initialized empty' do
      expect(generator.pages).to be_empty
    end

    it 'is an array' do
      expect(generator.pages).to be_instance_of Array
    end
  end

  describe '#generate' do
    it 'calls entries on dir' do
      expect(Dir).to receive(:entries).with('./pages').and_return []
      generator.generate(site)
    end

    context 'with pages' do
      before do
        allow(Dir).to receive(:entries).with('./pages') do
          ['./pages/test.md']
        end
      end

      it 'reads the file' do
        expect(File).to receive(:read).with('./pages/test.md') do
          "Content"
        end
        allow(Dir).to receive(:mkdir)
        allow(generator).to receive(:write_pages)

        generator.generate(site)
      end
    end
  end

  describe '#write' do
    it 'renders the templates' do
      allow(Dir).to receive(:pwd) do
        '/home/site'
      end

      layout_generator = Miniblog::Generators::Layout.new(site)

      allow(site).to receive(:generator).with(:layout) do
        layout_generator
      end

      allow(layout_generator).to receive(:layout) do
        Miniblog::Layout.new("---\ntest: test\n---\n.derp\n  =yield")
      end

      page = Miniblog::Page.new(
        "---\nlayout: page\n---\n%h1 Content",
        '/home/site/pages/derp'
      )

      generator.instance_variable_set(:@pages, [page])

      generator.write(site)
    end
  end

end
