# frozen_string_literal: true

require "bindata"

module H3m
  # Utilitary methods to extend BinData::Record subclasses
  module RecordUtil
    # Simplifed OptionMerger from ActiveSupport
    class OptionMerger
      def initialize(context, options)
        @context = context
        @options = options
      end

      def method_missing(method, *arguments, &block)
        arguments <<
          if arguments.last.respond_to?(:to_hash)
            @options.merge(arguments.pop)
          else
            @options.dup
          end

        @context.__send__(method, *arguments, &block)
      end

      def respond_to_missing?(method, *)
        super
      end
    end

    def with_options(options, &blk)
      blk.call OptionMerger.new(self, options)
    end
  end
end
