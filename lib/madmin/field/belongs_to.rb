module Madmin
  class Field
    ##
    # This field represents a :belongs_to relationship within a Rails model.
    class BelongsTo < Madmin::Field
      include Madmin::Field::Associatable
    end
  end
end
