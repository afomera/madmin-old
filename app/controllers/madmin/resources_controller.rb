require_dependency "madmin/application_controller"

module Madmin
  class ResourcesController < ApplicationController
    include ActiveSupport::Inflector

    helper_method :madmin_resource
    helper_method :resource_name

    def index
      @resources = resource.all
    end

    def show
      @resource = resource.find(params[:id])
    end

    def new
      @resource = resource.new
    end

    def create
      @resource = resource.create(resource_params)

      redirect_to resource_path(id: @resource.id)
    end

    def edit
      @resource = resource.find(params[:id])
    end

    def update
      @resource = resource.find(params[:id])
      @resource.update(resource_params)

      redirect_to resource_path(id: @resource.id)
    end

    def destroy
      @resource = resource.find(params[:id])
      @resource.destroy!

      redirect_to resources_path(params[:resource])
    end

    private

    def madmin_resource
      Object.const_get("::Resources::#{resource_name}")
    end

    def resource
      Object.const_get(resource_name)
    end

    def resource_name
      camelize(params[:resource].singularize)
    end

    def resource_params
      params.require(resource_name.downcase.to_sym).permit(resource.permitted_params)
    end
  end
end
