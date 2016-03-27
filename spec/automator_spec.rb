require 'spec_helper'

RSpec.describe Automator, type: :model do
  describe "Automator#initialze" do
    it "should correctly initialze the states for the input string" do
      a = Automator.new('test')

      expect(a.states[1].label).to eq 'T'
      expect(a.states[4].label).to eq 'TEST'

      expect(a.states[4].success?).to eq true
      expect(a.states[2].success?).to eq false

      expect(a.states[0].transitions.size).to eq 1
      expect(a.states[0].transitions['T']).to eq a.states[1]
      expect(a.states[3].transitions['T']).to eq a.states[4]
      expect(a.states[4].transitions.empty?).to eq true
    end
  end

  describe "Automator#read_string" do
    it "should only read the string that it is initialized with" do
      a = Automator.new('test')

      expect(a.read_string('TEST')).to be_truthy
      expect(a.read_string('CAT')).to be_falsey
      expect(a.read_string('TES')).to be_falsey
      expect(a.read_string('TSET')).to be_falsey
    end
  end
end
