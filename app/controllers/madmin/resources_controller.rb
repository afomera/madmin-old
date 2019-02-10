require_dependency "madmin/application_controller"

module Madmin
  class ResourcesController < ApplicationController
    include ActiveSupport::Inflector

    before_action :find_resource, only: [:show, :edit, :update, :destroy]

    helper_method :resource

    def index
      @resources = resource.all
    end

    def show; end

    def new
      @resource = ResourceDecorator.new(resource.new)
    end

    def create
      @resource = resource.create(resource_params)

      redirect_to resource_path(id: @resource.id)
    end

    def edit; end

    def update
      @resource.update(resource_params)

      redirect_to resource_path(id: @resource.id)
    end

    def destroy
      @resource.destroy!

      redirect_to resources_path(params[:resource])
    end

    private

    def find_resource
      @resource ||= Madmin::ResourceDecorator.new(resource.find(params[:id]))
    end

    def madmin_resource
      Object.const_get("::Madmin::Resources::#{resource_name}Resource")
    end

    def resource
      Object.const_get(resource_name)
    end

    def resource_name
      camelize(params[:resource].singularize)
    end

    def resource_params
      params.require(resource_name.downcase.to_sym).permit(madmin_resource.editable_fields.keys)
    end
  end
end
