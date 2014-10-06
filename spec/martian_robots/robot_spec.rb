require "spec_helper"

describe MartianRobots::Robot do

  subject             { Robot.new(position: position, instructions: instructions) }
  let(:position)      { "1 1 E" }
  let(:instructions)  { "RRFRFRFRF" }
  
  describe "#initialize" do

    let(:parsed_instructions) { instructions.chars }

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
      expect(subject.coordinates).to eq [1,1]
    end

    it "updates the robot's current movement" do
      subject.move
      expect(subject.direction).to eq "S"
      expect(subject.coordinates).to eq [1,1]
      2.times { subject.move }
      expect(subject.coordinates).to eq [0,1]
    end
  end

  describe "#next_coordinate" do

    it "returns the robot's next coordinate without altering them" do
      expect(subject.next_coordinate).to eq [1,1]
      expect(subject.coordinates).to eq [1,1]
    end
  end

  describe "#position" do

    context "not lost" do

      it "returns the robot's current position and direction" do
        subject.move
        expect(subject.position).to eq "1 1 S"
      end
    end

    context "lost" do

      it "returns the same + 'LOST' " do
        subject.move
        subject.lost = true
        expect(subject.position).to eq "1 1 S LOST"
      end
    end
  end
end