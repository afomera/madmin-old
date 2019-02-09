require_dependency "madmin/application_controller"

module Madmin
  class DashboardController < ApplicationController
    def index
      @resources = Madmin::Resources.gather
    end
  end
end
