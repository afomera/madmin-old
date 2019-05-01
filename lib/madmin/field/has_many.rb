module Madmin
  class Field
    ##
    # This field represents a :has_many relationship within a Rails model.
    class HasMany < Madmin::Field
      include Madmin::Field::Associatable
    end
  end
end
