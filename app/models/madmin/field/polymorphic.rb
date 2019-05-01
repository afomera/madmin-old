module Madmin
  class Field
    class Polymorphic < Madmin::Field
      def self.polymorphic?
        true
      end
    end
  end
end
