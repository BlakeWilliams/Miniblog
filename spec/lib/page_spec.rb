require 'spec_helper'

describe Miniblog::Page do
  describe '#path_name' do
  end

  describe 'path' do
    it 'returns the path with file name' do
      allow(Dir).to receive(:pwd) do
        "/home/pages"
      end

      page = Miniblog::Page.new('Content', '/home/pages/test.markdown')
      expect(page.path).to eq('./test')
    end

    it 'returns nested paths with file name' do
      allow(Dir).to receive(:pwd) do
        "/home/pages"
      end

      page = Miniblog::Page.new('Content', '/home/pages/test/file.markdown')
      expect(page.path).to eq('test/file')
    end
  end

  describe 'file_name' do
    it 'returns the file name without extension or path' do
      page = Miniblog::Page.new('Content', '/home/pages/test.md')
      expect(page.file_name).to eq('test')
    end
  end
end
