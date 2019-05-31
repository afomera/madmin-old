module Madmin
  class ApplicationController < BaseController
    protect_from_forgery with: :exception

    before_action :authenticate!

    private

    def authenticate!
      # redirect_to x_path unless current_user
      #
      # If using Devise, set this method to call:
      # authenticate_user!
    end
  end
end
