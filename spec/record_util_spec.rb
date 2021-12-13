# frozen_string_literal: true

require "spec_helper"

RSpec.describe H3m::RecordUtil do
  context "with_options method" do
    before(:example) do
      @class = Class.new do
        extend H3m::RecordUtil

        def self.my_method; end
      end
    end

    it "should call original method options" do
      expect(@class).to receive(:my_method).with({ x: 1 })

      @class.class_eval do
        # rubocop:disable Style/SymbolProc
        with_options(x: 1) do |o|
          o.my_method
        end
        # rubocop:enable Style/SymbolProc
      end
    end

    it "should merge options" do
      expect(@class).to receive(:my_method).with({ x: 1, y: 2 })

      @class.class_eval do
        with_options(x: 1) do |o|
          o.my_method y: 2
        end
      end
    end
  end
end
