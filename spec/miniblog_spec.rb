require 'spec_helper'

describe Miniblog do
  describe Miniblog::Site do
    it 'is an instance of Miniblog::SiteSingleton' do
      expect(Miniblog::Site).to be_instance_of(Miniblog::SiteSingleton)
    end
  end
end
