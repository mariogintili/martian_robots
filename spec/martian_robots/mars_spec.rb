require "spec_helper"

describe MartianRobots::Mars do

  let(:limits)      { [5,3] }
  let(:robot)       { double('robot', coordinates: [10,10] ) }
  subject           { Mars.new(limits: limits) }

  describe "#initialize" do

    it "takes in coordinates and sets a limit" do
      expect(subject.limits).to eq limits
      expect(subject.x_limit).to eq 5
      expect(subject.y_limit).to eq 3
    end

    it "enforces a maximum length of 50 for any coordinate" do
      expect { Mars.new(limits: [51, 30]) }.to raise_error
      expect { Mars.new(limits: [30, 51]) }.to raise_error
    end
  end

  describe "#in?" do

    it "returns true for coordinates that are inside its limits" do
      expect(subject.in?([3,3])).to be_truthy
      expect(subject.in?([3,4])).to be_falsey
      expect(subject.in?([-1,2])).to be_falsey
      expect(subject.in?([1,-1])).to be_falsey
      expect(subject.in?([3,3])).to be_truthy
      expect(subject.in?([5,3])).to be_truthy
    end
  end
end