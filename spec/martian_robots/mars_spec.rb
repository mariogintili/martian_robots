require "spec_helper"

describe MartianRobots::Mars do

  let(:coordinates) { [5,3] }
  let(:robot)       { double('robot', coordinates: [10,10] ) }
  subject           { Mars.new(coordinates: coordinates) }

  describe "#initialize" do

    it "takes in an array coordinates and creates rectangular grid" do
      expect(subject.grid).to be_a Array
      expect(subject.grid.flatten.length).to eq coordinates.inject(:*)
    end

    it "enforces a maximum length of 50 for any coordinate" do
      expect { Mars.new(coordinates: [51, 30]) }.to raise_error
      expect { Mars.new(coordinates: [30, 51]) }.to raise_error
    end
  end
end