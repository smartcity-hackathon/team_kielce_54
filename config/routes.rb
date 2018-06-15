# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :categories, only: :index, param: :name do
      resources :projects, only: :index
    end
  end
end
