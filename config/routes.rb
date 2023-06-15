Rails.application.routes.draw do
  root 'glossaries#index'

  resources :glossaries
  resources :glossaries do
    resources :words
  end
end
