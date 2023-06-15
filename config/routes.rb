Rails.application.routes.draw do
  root 'glossaries#index'

  resources :glossaries
  resources :glossaries do
    resources :categories
    resources :words
  end
end
