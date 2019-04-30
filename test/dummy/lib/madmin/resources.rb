module Madmin
  class Resources
    def self.all
      [User, Car, Madmin::Resources::Cars::Review]
    end
  end
end
