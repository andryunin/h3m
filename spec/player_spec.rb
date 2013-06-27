require "spec_helper"
require 'yaml'

describe H3m::Player do

  before :all do
    @fixtures = YAML.load_file("spec/resources.yml")
    @files = @fixtures.map do |p|
      {map: H3m::Map.new("spec/resources/#{p["file"]}"), params: p }
    end
  end

  it "should correcty determine player presence" do
    @files.each do |file|
      file[:map].players.each_with_index do |p, i|
        p.present?.should == file[:params]["players"][i]["present"]
      end
    end
  end

  it "should correcty determine player availability to human and computer" do
    @files.each do |file|
      players = file[:map].players.select {|p| p.present? }
      players.each_with_index do |p, i|
        p.human?.should == file[:params]["players"][i]["human"]
        p.computer?.should == file[:params]["players"][i]["human"]
      end
    end
  end

  it "should correcty determine computer behaviour" do
    @files.each do |file|
      players = file[:map].players.select {|p| p.computer? }
      players.each_with_index do |p, i|
        p.computer_behaviour.should == file[:params]["players"][i]["computer_behaviour"]
      end
    end
  end

  it "should correcty determine has player town on start or not" do
    @files.each do |file|
      players = file[:map].players.select {|p| p.present? }
      players.each_with_index do |p, i|
        p.has_town_on_start?.should == file[:params]["players"][i]["has_town_on_start"]
      end
    end
  end

end