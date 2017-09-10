Rails.application.routes.draw do
  root 'pages#top'

  get '/gifts/:lottery_code', to:'gifts#index', as: 'gift_edit_page'

  resources :owners
  resources :lotteries, param: :code
  resources :gifts
end
