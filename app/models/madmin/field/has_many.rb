module Madmin
  class Field
    class HasMany < Madmin::Field
      def self.association?
        true
      end
    end
  end
end
