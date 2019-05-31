Rails.application.routes.draw do
  namespace :madmin do
    get "test", to: "test#index"
  end
  mount Madmin::Engine => "/madmin"
end
