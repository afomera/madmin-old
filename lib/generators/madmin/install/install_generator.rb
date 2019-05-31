require "rails/generators/base"
require "madmin/generator_helpers"

module Madmin
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Madmin::GeneratorHelpers

      def generate_resources
        resources.each do |model|
          call_generator "madmin:resource", model.to_s
        end
      end

      def install_route
        inject_into_file(
          Rails.root.join("config/routes.rb"),
          after: "Rails.application.routes.draw do\n"
        ) { "  namespace :madmin do\n  end\n  mount Madmin::Engine => \"/madmin\"\n" }
      end

      private

      def resources
        Rails.application.eager_load! unless Rails.application.config.cache_classes

        ActiveRecord::Base.descendants.reject(&:abstract_class?)
      end
    end
  end
end
