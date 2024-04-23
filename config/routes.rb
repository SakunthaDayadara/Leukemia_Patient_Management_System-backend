Rails.application.routes.draw do
  resources :patients do
    collection do
      get 'find_by_patient_id'
      get 'auto_login'
      post 'login'
    end

  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
