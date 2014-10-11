require "spec_helper"

describe MartianRobots::Robot do

  subject             { Robot.new(position: position, instructions: instructions) }
  let(:position)      { "3 2 N" }
  let(:instructions)  { "FRRFLLFFRRFLL" }
  let(:mars)          { double("mars", limits: [5, 3], x_limit: 5, y_limit: 3, set_forbbiden_state: nil, in?: nil, allowed?: nil)}
  
  describe "#initialize" do

    let(:parsed_instructions) { instructions.chars }

    it "takes in a position and moving instructions, and sets them as attributes" do
      expect(subject.coordinates).to eq([3,2])
      expect(subject.direction).to eq "N"
      expect(subject.instructions).to eq parsed_instructions
    end
  end

  describe "#lost?" do

    it "is false by default" do
      expect(subject.lost?).to be_falsey
    end
  end

  describe "#state" do

    it "returns a hash with the current coordinates and direction" do
      expect(subject.state).to eq({ coordinates: [3,2], direction: "N"})
    end
  end

  describe "#move_on" do

    it "checks if the surface has such next coordinates" do
      expect(mars).to receive(:in?).with([3,3])
      subject.move_on mars
    end

    it "checks if the next coordinate is not forbidden" do
      expect(mars).to receive(:allowed?).with(subject.state)
      allow(mars).to receive(:in?).and_return(true)
      subject.move_on mars
    end

    it "deletes the first instruction" do
      allow(mars).to receive(:in?).with([3,3]).and_return(true)
      allow(mars).to receive(:allowed?).and_return(true)
      subject.move_on mars
      expect(subject.instructions.first).not_to eq "F"
    end

    context "Changing direction" do

      it "updates the robots direction but not its coordinates" do
        subject.instructions = ["R", "R"]
        allow(mars).to receive(:in?).and_return(true)
        allow(mars).to receive(:allowed?).and_return(true)
        subject.move_on(mars)
        expect(subject.coordinates).to eq [3,2]
        expect(subject.direction).to eq "E"
      end
    end

    context "Moving" do

      context "with valid coordinates" do

        it "upgrades #coordinates if the surface has those coordinates" do
          allow(mars).to receive(:in?).with([3,3]).and_return(true)
          allow(mars).to receive(:allowed?).and_return(true)
          subject.move_on mars
          expect(subject.coordinates).to eq [3,3]
        end
      end

      context "with invalid coordinates" do

        it "does not upgrade the coordinates" do
          allow(mars).to receive(:in?).with([3,3]).and_return(false)
          subject.move_on mars
          expect(subject.coordinates).to eq [3,2]
        end

        it "marks the robot as lost" do
          allow(mars).to receive(:in?).with([3,3]).and_return(false)
          allow(mars).to receive(:allowed?).with(subject.state).and_return(true)
          subject.move_on mars
          expect(subject.lost?).to be_truthy
        end

        it "declares a forbidden state on the surface" do
          expect(mars).to receive(:set_forbbiden_state).with(subject.state)
          allow(mars).to receive(:in?).with([3,3]).and_return(false)
          allow(mars).to receive(:allowed?).with(subject.state).and_return(true)
          subject.move_on mars
        end
      end
    end
  end

  describe "#position" do

    context "not lost" do

      it "returns the robot's current position and direction" do
        expect(subject.position).to eq "3 2 N"
      end
    end

    context "lost" do

      it "returns the same + 'LOST' " do
        subject.vanish
        expect(subject.position).to eq "3 2 N LOST"
      end
    end
  end
end
