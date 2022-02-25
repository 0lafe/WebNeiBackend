Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "homes#index"

  namespace :api do
    namespace :recipes do
      resources :items, only: [:show] do
        resources :recipe_types, only: [:show]
      end
      resources :recipe_types, only: [:show]
    end
    resources :items, only: [:show]
    resources :recipes, only: [:index, :show]
    resources :recipe_types, only: [:index, :show]
  end

  get "*path", to: "homes#index"

end
