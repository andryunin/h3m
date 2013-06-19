require "spec_helper"

describe H3m::Map do

  before :all do
    @files  = Dir.glob("spec/resources/*.h3m")
    @params = @files.map do |path|
      filename = File.basename(path, ".h3m")
      version, size = filename.split("_").map(&:to_sym)
      {version: version, size: size}
    end

  end

  it "should return correct version" do
    @files.each_with_index do |path, index|
      params = @params[index]
      map = H3m::Map.new(path)
      map.version.should == params[:version]
    end
  end

  it "should return correct size" do
    @files.each_with_index do |path, index|
      params = @params[index]
      map = H3m::Map.new(path)
      map.size.should == params[:size]
    end
  end

end