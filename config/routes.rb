Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post "sign_in" => "sessions#create", as: :sign_in
  delete "sign_out" => "sessions#destroy", as: :sign_out

  get "wallet" => "wallets#mine", as: :my_wallet
  get  "wallet/transactions" => "wallets#transactions", as: :my_wallet_transactions
  post "wallet/deposit" => "wallets#deposit", as: :deposit
  post "wallet/withdraw" => "wallets#withdraw", as: :withdraw
  post "wallet/transfer" => "wallets#transfer", as: :transfer
  get  "wallets" => "wallets#index", as: :wallets

  # Defines the root path route ("/")
  # root "posts#index"
end
