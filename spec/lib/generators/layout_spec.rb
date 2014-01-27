require 'spec_helper'

describe Miniblog::Generators::Layout do
  let(:site) { double('site') }
  let(:generator) { Miniblog::Generators::Layout.new(site) }

  describe '#layouts' do
    it 'is initialized empty' do
      expect(generator.layouts).to be_empty
    end

    it 'is a hash' do
      expect(generator.layouts).to be_instance_of Hash
    end
  end

  describe '#generate' do
    it 'calls entries on dir' do
      expect(Dir).to receive(:entries).with('./layouts').and_return []
      generator.generate(site)
    end

    it 'reads returned files' do
      path = './layouts/test.haml'
      allow(Dir).to receive(:entries).with('./layouts') do
        [path]
      end

      expect(File).to receive(:read).with(path) do
        "Content"
      end

      generator.generate(site)
    end

    context 'layouts' do
      before do
        path = './layouts/test.haml'
        allow(Dir).to receive(:entries).with('./layouts') do
          [path]
        end

        allow(File).to receive(:read).with(path) do
          "Content"
        end
      end

      it 'adds layout instance to layouts' do
        generator.generate(site)
        expect(generator.layouts[:test]).to be_instance_of(Miniblog::Layout)
      end

      it 'has proper content' do
        generator.generate(site)
        expect(generator.layouts[:test].content).to eq("Content")
      end
    end

  end
end
