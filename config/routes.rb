Rails.application.routes.draw do
  resources :customers do
    resources :contracts
  end
end
