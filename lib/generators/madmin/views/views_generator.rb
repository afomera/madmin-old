require "rails/generators/base"

module Madmin
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      description('Copies views for customizing the Resource Fields')

      source_root File.expand_path("../../../../..", __FILE__)

      def copy_views
        directory "app/views/madmin/fields", "app/views/madmin/fields"
      end
    end
  end
end
