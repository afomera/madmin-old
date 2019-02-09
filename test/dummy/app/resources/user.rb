module Resources
  class User < Madmin::Resource
    editable_fields :id, :first_name, :last_name
  end
end
