# frozen_string_literal: true

Rails.application.routes.draw do
  draw_routes_for :api_current
  draw_routes_for :api_v1

  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
end
