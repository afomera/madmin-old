module Madmin
  class Field
    ##
    # This field represents a select dropdown value.
    class Select < Madmin::Field
      attr_reader :select_options

      def initialize(args)
        @select_options = option_or_default(:collection, [])
      end
    end
  end
end
