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

  describe "#initialize" do

    it "places the robots on the grid" do
      expect(subject.mars.grid[1][1]).to eq robot_one
      expect(subject.mars.grid.last[2]).to eq robot_two
      expect(subject.mars.grid[0][3]).to eq robot_three
    end
  end
end