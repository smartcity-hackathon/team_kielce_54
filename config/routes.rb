# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :sessions, only: :create
    namespace :my do
      resources :projects, only: :index
    end

    resources :categories, only: :index, param: :name do
      resources :projects, only: %i[index show create] do
        get :archived, on: :collection
      end
    end
  end
end
