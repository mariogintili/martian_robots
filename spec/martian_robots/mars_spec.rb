require "spec_helper"

describe MartianRobots::Mars do

  let(:limits)          { [5,3] }
  let(:robot)           { double('robot', coordinates: [10,10] ) }
  let(:forbidden_state) { {coordinates: [0,0], direction: "S"} }
  subject               { Mars.new(limits: limits) }

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

  describe "#set_forbidden_state" do

    before { subject.set_forbbiden_state(forbidden_state) }

    it "pushes a new forbidden states to the #forbidden_states" do
      expect(subject.forbidden_states).to include forbidden_state
    end
  end

  describe "#allowed?" do

    before { subject.set_forbbiden_state(forbidden_state) }

    it "checks if the given state is forbidden" do
      expect(subject.allowed?(forbidden_state)).to be_falsey
      expect(subject.allowed?({ coordinates: [1,1], direction: "E"})).to be_truthy
    end
  end
end