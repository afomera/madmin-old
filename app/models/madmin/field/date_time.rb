module Madmin
  class Field
    class DateTime < Madmin::Field
      def input
        "datetime_local_field"
      end
    end
  end
end
