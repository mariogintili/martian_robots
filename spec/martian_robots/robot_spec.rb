require "spec_helper"

describe MartianRobots::Robot do

  subject             { Robot.new(position: position, instructions: instructions) }
  let(:position)      { "1 1 E" }
  let(:instructions)  { "RRFRFRFRF" }
  
  describe "#initialize" do

    let(:parsed_instructions) { instructions.split("F") }

    it "takes in a position and moving instructions, and sets them as attributes" do
      expect(subject.coordinates).to eq([1,1])
      expect(subject.direction).to eq "E"
      expect(subject.instructions).to eq parsed_instructions
    end
  end

  describe "#lost?" do

    it "is false by default" do
      expect(subject.lost?).to be_falsey
    end
  end

  describe "#move" do

    it "returns the self's new coordinates" do
      subject.move
      expect(subject.coordinates).to eq [0,1]
    end

    it "updates the robot's current movement" do
      subject.move
      expect(subject.direction).to eq "W"
      expect(subject.coordinates).to eq [0,1]
      subject.move
      expect(subject.coordinates).to eq [0,2]
    end
  end
end