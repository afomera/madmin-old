require "rails/generators/base"

module Madmin
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      desc("Copies views for customizing Madmin's views")

      source_root File.expand_path("../../../../..", __FILE__)

      def copy_views
        directory "app/views/madmin", "app/views/madmin"
      end
    end
  end
end
