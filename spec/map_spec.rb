require "spec_helper"
require "yaml"

describe H3m::Map do
  before :all do
    @fixtures = YAML.load_file("spec/resources.yml")
    @files = @fixtures.map do |p|
      { path: "spec/resources/#{p["file"]}", params: p }
    end
  end

  before :each do
    # File for testing errors: 10 kb of 0xFF except for the lengths of
    # map name and descriptions
    content = "\xFF" * 10_240
    content[10...18] = "\x00" * 8
    @badfile = StringIO.new(content, "rb")
  end

  it "should return correct version" do
    @files.each do |file|
      map = H3m::Map.new(file[:path])
      map.version.should == file[:params]["version"].to_sym
    end

    expect do
      map = H3m::Map.new(@badfile, true)
      map.version
    end.to raise_error(H3m::MapError)
  end

  it "should return correct size" do
    @files.each do |file|
      map = H3m::Map.new(file[:path])
      map.size.should == file[:params]["size"].to_sym
    end

    expect do
      map = H3m::Map.new(@badfile, true)
      map.size
    end.to raise_error(H3m::MapError)
  end

  it "should return correct name and description" do
    @files.each do |file|
      map = H3m::Map.new(file[:path])
      map.name.should == file[:params]["name"]
      map.description.should == file[:params]["description"]
    end

    expect do
      map = H3m::Map.new(@badfile, true)
      map.name
    end.to raise_error(H3m::MapError)
  end

  it "should correctly determine subterranean presence" do
    @files.each do |file|
      map = H3m::Map.new(file[:path])
      map.has_subterranean?.should == file[:params]["has_subterranean"]
    end

    expect do
      map = H3m::Map.new(@badfile, true)
      map.has_subterranean?
    end.to raise_error(H3m::MapError)
  end

  it "should correctly determine map difficulty" do
    @files.each do |file|
      map = H3m::Map.new(file[:path])
      map.difficulty.should == file[:params]["difficulty"].to_sym
    end

    expect do
      map = H3m::Map.new(@badfile, true)
      map.difficulty
    end.to raise_error(H3m::MapError)
  end

  it "should return 8 player instances" do
    @files.each do |file|
      map = H3m::Map.new(file[:path])
      map.players.size.should == 8
      map.players.each do |player|
        player.should be_an_instance_of(H3m::Player)
      end
    end
  end
end
