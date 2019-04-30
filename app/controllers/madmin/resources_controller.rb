require_dependency "madmin/application_controller"

module Madmin
  class ResourcesController < ApplicationController
    include ActiveSupport::Inflector

    before_action :find_resource, only: [:show, :edit, :update, :destroy]

    helper_method :resource

    def index
      @scopes = madmin_resource.scopes
      @headers = madmin_resource.index_fields.keys

      if params[:scope]&.to_sym&.in?(@scopes)
        begin
          @resources = resource.send(params[:scope]).map { |r| ResourceDecorator.new(r) }
        rescue ArgumentError
          raise ScopeWithArgumentsError, "The scope #{params[:scope.to_sym]} on #{resource.name} takes arguments, which are currently unsupported."
        end
      else
        @resources = resource.all.map { |r| ResourceDecorator.new(r) }
      end
    end

    def show
    end

    def new
      @resource = ResourceDecorator.new(resource.new)
    end

    def create
      @resource = ResourceDecorator.new(resource.new(resource_params))

      if @resource.save
        redirect_to resource_path(id: @resource.id)
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @resource.update(resource_params)
        redirect_to resource_path(id: @resource.id)
      else
        render :edit
      end
    end

    def destroy
      if @resource.destroy
        redirect_to resources_path(params[:resource])
      else
        flash[:error] = "There was an issue deleting the record."
        redirect_to :back
      end
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
      params.require(resource_name.downcase.to_sym)
        .permit(madmin_resource.formable_fields.keys)
    end
  end
end
