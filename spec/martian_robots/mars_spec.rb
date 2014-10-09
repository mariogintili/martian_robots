require "spec_helper"

describe MartianRobots::Mars do

  let(:coordinates) { [5,3] }
  let(:robot)       { double('robot', coordinates: [10,10] ) }
  subject           { Mars.new(coordinates: coordinates) }

  describe "#initialize" do

    it "takes in coordinates and sets a limit" do
      expect(subject.limit).to eq coordinates.inject(:*)
    end

    it "enforces a maximum length of 50 for any coordinate" do
      expect { Mars.new(coordinates: [51, 30]) }.to raise_error
      expect { Mars.new(coordinates: [30, 51]) }.to raise_error
    end
  end
end