Rails.application.routes.draw do
  get 'pages/top'

  resources :owners
  resources :lotteries
end
