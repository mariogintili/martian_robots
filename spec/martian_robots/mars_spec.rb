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

  describe "#find" do

    context "with a found entry" do

      it "returns the found element" do
        subject.grid[1][1] = robot
        expect(subject.find(robot)).to eq robot
      end
    end

    context "without a found entry" do

      it "returns nil" do
        expect(subject.find(robot)).to eq nil
      end
    end
  end

  describe "#coordinates_for" do

    context "with a found entry" do

      it "returns the coordinates of the given object" do
        subject.grid[1][1] = robot
        expect(subject.coordinates_for(robot)).to eq [1,1]
      end
    end

    context "not found entry" do

      it "returns nil" do
        expect(subject.coordinates_for(robot)).to eq nil
      end
    end
  end

  describe "#find_by_coordinate" do

    context "with an entry" do

      it "returns the coordinates" do
        subject.grid[1][1] = robot
        expect(subject.find_by_coordinate([1,1])).to eq robot
      end
    end

    context "without an entry" do

      it "returns nil" do
        expect(subject.find_by_coordinate([6,6])).to eq nil
        expect(subject.find_by_coordinate([2,2])).to eq nil
      end

    end
  end

  describe "#valid?" do

    it "returns false if the coordinate is outside of the grid" do
      expect(subject.valid?([10,10])).to be_falsey
      expect(subject.valid?([3,10])).to be_falsey
      expect(subject.valid?([10,3])).to be_falsey
      expect(subject.valid?([5,3])).to be_truthy
      expect(subject.valid?([0,0])).to be_truthy
      expect(subject.valid?([3,4])).to be_falsey
    end
  end

  describe "#upgrade_location" do

    let(:robot) { double('robot',coordinates: [0,0], next_coordinate: next_coordinates, vanish: nil) }

    context "when it's forbidden" do

      let(:next_coordinates) { [1,1] }

      it "tells the robot to ignore future movement" do
        subject.forbidden_coordinates.push next_coordinates
        subject.grid[0][0] = robot
        expect(robot).to receive(:ignore!)
        subject.upgrade_location(robot)
      end
    end

    context "when it's off the edge" do

      let(:next_coordinates) { [3,4] }

      it "marks the robot as lost" do
        subject.grid[2][3] = robot
        expect(robot).to receive(:vanish)
        subject.upgrade_location(robot)
      end
    end

    context "under valid circumstances" do

      let(:next_coordinates) { [2,2] }

      it "tells the robot to move" do
        subject.grid[1][1] = robot
        expect(robot).to receive(:move)
        subject.upgrade_location(robot)
      end 
    end
  end
end