Rails.application.routes.draw do
  root 'pages#top'

  get '/lotteries', to:'lotteries#show'
  get '/lotterie/deal', to:'pages#deal'
  post '/create_tickets', to:'tickets#deal'

  resources :owners
  resources :lotteries, param: :code
  resources :gifts  #  , param: :seq
  resources :tickets

  ### 開発用画面 ###
  # キャッシュをいじる
  # https://simple-lottery-sano400jp.c9users.io/cacheedit
  get 'cacheedit', to:'devpages#cacheedit'

end
