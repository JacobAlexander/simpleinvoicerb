# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products
  resources :invoices, only: %i(index show)
  resource :checkout, only: %i(show) do
    get 'add_product/:id', to: 'checkouts#add_product', as: :add_product
    post 'add_product', to: 'checkouts#add_product_by_code', as: :add_product_by_code
    get 'remove_product/:id', to: 'checkouts#remove_product', as: :remove_product
    get 'close_invoice', to: 'checkouts#close_invoice', as: :close_invoice
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'products#index'
end
