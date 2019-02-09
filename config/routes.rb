Madmin::Engine.routes.draw do
  root to: "dashboard#index"

  get "/:resource", to: "resources#index", as: :resources
  get "/:resource/new", to: "resources#new", as: :new_resource
  post "/:resource", to: "resources#create"
  get "/:resource/:id", to: "resources#show", as: :resource
  get "/:resource/:id/edit", to: "resources#edit", as: :edit_resource
  patch  "/:resource/:id", to: "resources#update"
  delete "/:resource/:id", to: "resources#destroy"
end
