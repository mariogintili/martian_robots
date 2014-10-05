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

  describe "#next_coordinate" do

    it "returns the robot's next coordinate without altering them" do
      expect(subject.next_coordinate).to eq [0,1]
      expect(subject.coordinates).to eq [1,1]
    end
  end

  describe "#position" do

    context "not lost" do

      it "returns the robot's current position and direction" do
        subject.move
        expect(subject.position).to eq "0 1 W"
      end
    end

    context "lost" do

      it "returns the same + 'LOST' " do
        subject.move
        subject.lost = true
        expect(subject.position).to eq "0 1 W LOST"
      end
    end
  end

  describe "#ignore!" do

    it "sets the robots final orientation" do
      subject.ignore!
      expect(subject.direction).to eq "S"
    end

    it  "does not alter the robots coordinates" do
      old_coords = subject.coordinates
      subject.ignore!
      expect(subject.coordinates).to eq old_coords
    end

    it "deletes all instructions" do
      subject.ignore!
      expect(subject.instructions.any?).to be_falsey
    end
  end
end