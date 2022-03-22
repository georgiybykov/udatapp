# frozen_string_literal: true

Rails.application.routes.draw do
  post 'registration',        to: 'users#create'
  post 'login',               to: 'sessions#create'
end
