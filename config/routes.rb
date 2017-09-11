Rails.application.routes.draw do
  root 'pages#top'

  get '/lotteries', to:'lotteries#show'

  resources :owners
  resources :lotteries, param: :code
  resources :gifts
end
