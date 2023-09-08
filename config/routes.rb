Rails.application.routes.draw do
  root 'glossaries#index'

  resources :glossaries
  resources :glossaries do
    resources :categories
    resources :words
  end
  resources :glossaries do
    member do
      get :export
    end
  end
  resources :glossaries do
    member do
      get :export_txt
    end
  end
  resources :glossaries do
    member do
      post :import_txt
    end
  end
end
