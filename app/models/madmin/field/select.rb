module Madmin
  class Field
    class Select < Madmin::Field
      def self.select?
        true
      end
    end
  end
end
