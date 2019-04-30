module Madmin
  class Field
    class BelongsTo < Madmin::Field
      def self.association?
        true
      end
    end
  end
end
