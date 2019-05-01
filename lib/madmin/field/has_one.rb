module Madmin
  class Field
    ##
    # This field represents a :has_one relationship within a Rails model.
    class HasOne < Madmin::Field
      include Madmin::Field::Associatable
    end
  end
end
