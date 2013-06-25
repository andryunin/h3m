require "spec_helper"

describe H3m::Map do

  before :all do
    @files  = Dir.glob("spec/resources/SoD_*.h3m")
    @params = @files.map do |path|
      filename = File.basename(path, ".h3m")
      version, size = filename.split("_").map(&:to_sym)
      {version: version, size: size}
    end
  end

  before :each do
    # File for testing errors: 10 kb of 0xFF except for the lengths of
    # map name and descriptions
    content = "\xFF" * 10240
    content[10...18] = "\x00" * 8
    @badfile = StringIO.new(content, "rb")
  end

  it "should return correct version" do
    @files.each_with_index do |path, index|
      params = @params[index]
      map = H3m::Map.new(path)
      map.version.should == params[:version]
    end

    expect {
      map = H3m::Map.new(@badfile, true)
      map.version
    }.to raise_error(H3m::MapError)
  end

  it "should return correct size" do
    @files.each_with_index do |path, index|
      params = @params[index]
      map = H3m::Map.new(path)
      map.size.should == params[:size]
    end

    expect {
      map = H3m::Map.new(@badfile, true)
      map.size
    }.to raise_error(H3m::MapError)
  end

  it "should return correct name and description" do
    map = H3m::Map.new("spec/resources/test_1.h3m")

    map.name.should == "test map name"
    map.description.should == "test map desc"
  end

  it "should correctly determine subterranean presence" do
    map = H3m::Map.new("spec/resources/test_1.h3m")
    map.has_subterranean?.should == true

    map = H3m::Map.new("spec/resources/test_2.h3m")
    map.has_subterranean?.should == false

    expect {
      map = H3m::Map.new(@badfile, true)
      map.has_subterranean?
    }.to raise_error(H3m::MapError)
  end

  it "should correctly determine map difficulty" do
    map = H3m::Map.new("spec/resources/test_1.h3m")
    map.difficulty.should == :normal

    map = H3m::Map.new("spec/resources/test_2.h3m")
    map.difficulty.should == :impossible

    expect {
      map = H3m::Map.new(@badfile, true)
      map.difficulty
    }.to raise_error(H3m::MapError)
  end

end