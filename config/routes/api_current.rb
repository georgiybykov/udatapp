# frozen_string_literal: true

Rails.application.routes.draw do
  scope Constants::API_CURRENT_VERSION, module: :api_current do
    post 'registration',        to: 'users#create'
    post 'login',               to: 'sessions#create'

    resources :notes, except: %i[new edit update]

    patch 'notes/:id', to: 'notes#update', constraints: { id: /\d+/ }
  end
end
