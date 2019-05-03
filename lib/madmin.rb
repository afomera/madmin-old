require "madmin/engine"
require "madmin/resourceable"
require "madmin/resources"

module Madmin
  class NoResourcesError < StandardError; end
  class ResourceNotFoundError < StandardError; end
  class WrongArgumentError < StandardError; end
  class UndefinedScopeError < StandardError; end
  class ScopeWithArgumentsError < StandardError; end

  autoload :Field,        "madmin/field"
  autoload :Resourceable, "madmin/resourceable"

  class Field
    autoload :Associatable, "madmin/field/associatable"
    autoload :BelongsTo,    "madmin/field/belongs_to"
    autoload :CheckBox,     "madmin/field/check_box"
    autoload :DateTime,     "madmin/field/date_time"
    autoload :Email,        "madmin/field/email"
    autoload :HasMany,      "madmin/field/has_many"
    autoload :HasOne,       "madmin/field/has_one"
    autoload :Number,       "madmin/field/number"
    autoload :Password,     "madmin/field/password"
    autoload :Polymorphic,  "madmin/field/polymorphic"
    autoload :Select,       "madmin/field/select"
    autoload :TextArea,     "madmin/field/text_area"
    autoload :Text,         "madmin/field/text"
  end
end
