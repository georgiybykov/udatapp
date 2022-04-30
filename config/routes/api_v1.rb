# frozen_string_literal: true

Rails.application.routes.draw do
  scope Constants::API_V1_VERSION, module: :api_v1 do
    patch 'notes/:id', to: 'notes#update', constraints: { id: /\d+/ }
  end

  scope Constants::API_V1_VERSION, module: :api_current do
    post 'registration',        to: 'users#create'
    post 'login',               to: 'sessions#create'

    resources :notes, except: %i[new edit update]
  end
end
