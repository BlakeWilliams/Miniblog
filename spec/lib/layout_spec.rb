require 'spec_helper'

describe Miniblog::Layout do
  describe 'render' do
    it 'expects 2 paramaters' do
      layout = Miniblog::Layout.new('test')
      expect{layout.render({})}.to raise_error
    end
  end
end
