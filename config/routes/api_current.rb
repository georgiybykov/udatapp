# frozen_string_literal: true

Rails.application.routes.draw do
  scope Common::API_CURRENT_VERSION, module: :api_current do
    post 'registration',        to: 'users#create'
    post 'login',               to: 'sessions#create'

    resources :notes, except: %i[new edit]
  end
end
