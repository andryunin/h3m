require "spec_helper"
require "yaml"

RSpec.describe H3m::Map do
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
      expect(map.game_version).to eq(file[:params]["game_version"].to_sym)
    end

    expect do
      map = H3m::Map.new(@badfile, true)
      map.game_version
    end.to raise_error(H3m::FormatError)
  end

  it "should return correct size" do
    @files.each do |file|
      map = H3m::Map.new(file[:path])
      expect(map.size).to eq(file[:params]["size"].to_sym)
    end

    expect do
      map = H3m::Map.new(@badfile, true)
      map.size
    end.to raise_error(H3m::FormatError)
  end

  it "should return correct name and description" do
    @files.each do |file|
      map = H3m::Map.new(file[:path])
      expect(map.name).to eq(file[:params]["name"])
      expect(map.description).to eq(file[:params]["description"])
    end

    expect do
      map = H3m::Map.new(@badfile, true)
      map.name
    end.to raise_error(H3m::FormatError)
  end

  it "should correctly determine subterranean presence" do
    @files.each do |file|
      map = H3m::Map.new(file[:path])
      expect(map.subterranean_level?).to eq(
        file[:params]["has_subterranean_level"]
      )
    end

    expect do
      map = H3m::Map.new(@badfile, true)
      map.subterranean_level?
    end.to raise_error(H3m::FormatError)
  end

  it "should correctly determine map difficulty" do
    @files.each do |file|
      map = H3m::Map.new(file[:path])
      expect(map.difficulty).to eq(file[:params]["difficulty"].to_sym)
    end

    expect do
      map = H3m::Map.new(@badfile, true)
      map.difficulty
    end.to raise_error(H3m::FormatError)
  end

  it "should return 8 player instances" do
    @files.each do |file|
      map = H3m::Map.new(file[:path])
      expect(map.players.size).to eq(8)
      map.players.each do |player|
        expect(player).to be_an_instance_of(H3m::Player)
      end
    end
  end
end
