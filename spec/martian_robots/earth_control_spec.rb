require "spec_helper"

describe MartianRobots::EarthControl do

  subject           { EarthControl.new(input: input) }
  let(:robot_one)   { subject.robots.first }
  let(:robot_two)   { subject.robots[1] }
  let(:robot_three) { subject.robots.last } 
  let(:input) do
    "53
    11E RFRFRFRF
    32N FRRFLLFFRRFLL
    03W LLFFFLFLFL"
  end

  let(:output) do
    "1 1 E\n3 3 N LOST\n2 3 S"
  end

  describe "#execute!" do

    it "makes the robots move" do
      expect(robot_one.coordinates).to eq [1,1]
      expect(robot_one.direction).to eq "E" 
      subject.execute!
    end

    it "ensures that robots that fell off are vanished" do
      subject.execute!
      expect(robot_two).to be_lost
      expect(robot_two.coordinates).to eq [3,3]
      expect(robot_two.direction).to eq "N"
    end

    it "ensures to taint the surface of mars so future robots ignore those points" do
      subject.execute!
      expect(robot_three.coordinates).to eq [2,3]
      expect(robot_three.direction).to eq "S"
    end
  end

  describe "#output" do

    it "returns the output from the activity" do
      subject.execute!
      expect(subject.output).to eq output
    end
  end
end