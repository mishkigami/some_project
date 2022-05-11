# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :notes, only: %i[index create show] do
        delete :remove_multiple, on: :collection
        patch :update_multiple, on: :collection
      end
    end
  end
end
