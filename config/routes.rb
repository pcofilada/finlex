Rails.application.routes.draw do
  resources :customers do
    resources :contracts
  end
  post :import_contracts, to: 'contracts#import'
end
