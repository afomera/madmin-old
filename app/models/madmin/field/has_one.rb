module Madmin
  class Field
    class HasOne < Madmin::Field
      def self.association?
        true
      end
    end
  end
end
