require 'spec_Helper'

describe Miniblog::SiteSingleton do
  let(:site) { Miniblog::SiteSingleton.instance }

  before do
    site.generators.each do |key, val|
      site.remove_generator(key)
    end
  end


  describe '#add_generator' do
    it 'creates a new instance of passed in generator ' do
      double = double('generator')
      expect(double).to receive(:new).with(site)

      site.add_generator(:test, double)
    end

    it 'adds generator by name' do
      double = double('generator')
      instance = double('generator_instance')
      allow(double).to receive(:new).with(site).and_return(instance)

      site.add_generator(:test, double)
      expect(site.generator(:test)).to eq(instance)
    end
  end

  describe 'remove_generator' do
    it 'removes the generator' do
      double = double('generator')
      instance = double('generator_instance')
      allow(double).to receive(:new).with(site).and_return(instance)

      site.add_generator(:test, double)
      site.remove_generator(:test)
      expect(site.generator(:test)).to be_nil
    end
  end

  describe 'generate_all' do
    it 'calls generate on all generators' do
      double = double('generator')
      instance = double('generator_instance')

      allow(double).to receive(:new).with(site).and_return(instance)
      expect(instance).to receive(:generate).with(site)

      site.add_generator(:test, double)
      site.generate_all
    end
  end
end
