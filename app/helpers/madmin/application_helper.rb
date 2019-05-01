module Madmin
  module ApplicationHelper
    def polymorphic_models(type)
      all_resources = Madmin::Resources.all.map { |r| Madmin::ResourceDecorator.new(r) }

      polymorphic_resources = all_resources.select do |resource|
        associations = resource.model.reflect_on_all_associations
        associations.select { |a| a.options.dig(:as) === type }.any?
      end

      polymorphic_resources.map(&:model)
    end
  end
end
