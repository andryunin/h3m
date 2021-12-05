require "spec_helper"
require "yaml"

RSpec.describe H3m::Player do
  @fixtures = YAML.load_file("spec/resources.yml")
  @files = @fixtures.map do |p|
    { path: "spec/resources/#{p["file"]}", params: p }
  end

  @files.each do |file|
    context "from file #{file[:path]}" do
      before :all do
        @map = H3m::Map.new(file[:path])
        @players = @map.players
        @present_players = @map.players.select { |p| p.present? }
        @computer_players = @map.players.select { |p| p.can_be_ai? }
      end

      it "should determine player presence" do
        @players.each_with_index do |p, i|
          expect(p.present?).to eq(file[:params]["players"][i]["present"])
        end
      end

      it "should determine player availability to human and computer" do
        @players.each_with_index do |p, i|
          expect(p.can_be_human?).to eq(
            file[:params]["players"][i]["human"] || false
          )

          expect(p.can_be_computer?).to eq(
            file[:params]["players"][i]["computer"] || false
          )
        end
      end

      it "should determine computer behaviour" do
        @players.each_with_index do |p, i|
          next unless file[:params]["players"][i]["computer_behaviour"]

          expect(p.computer_behaviour).to eq(
            file[:params]["players"][i]["ai_behaviour"].to_sym
          )
        end
      end
    end
  end
end
