Rails.application.routes.draw do
  root 'pages#top'

  resources :owners
  resources :lotteries
end
