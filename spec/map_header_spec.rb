# frozen_string_literal: true

require "spec_helper"
require "yaml"

RSpec.describe H3m::Map do
  YAML.load_file("spec/resources/resources.yml").each do |map_spec|
    map_file = map_spec["file"]
    map_path = "spec/resources/#{map_spec["file"]}"
    map = H3m::Map.new(map_path)

    it "should parse game_version for #{map_file}" do
      expect(map.game_version).to eq map_spec["game_version"]
    end

    it "should parse map size for #{map_file}" do
      expect(map.size).to eq map_spec["size"]
    end

    it "should parse map name for #{map_file}" do
      expect(map.name).to eq map_spec["name"]
    end

    it "should parse map description for #{map_file}" do
      expect(map.description).to eq map_spec["description"]
    end

    it "should parse difficulty for #{map_file}" do
      expect(map.difficulty).to eq map_spec["difficulty"]
    end

    it "should parse subterranean_level flag for #{map_file}" do
      expect(map.subterranean_level?).to eq map_spec["has_subterranean_level"]
    end
  end
end
