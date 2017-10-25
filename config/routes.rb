Rails.application.routes.draw do
  root 'pages#top'

  get '/lotteries', to:'lotteries#show'
  get '/lotteries/deal', to:'pages#deal'
  get '/lotteries/draw', to:'lotteries#draw'
  post '/deal_tickets', to:'tickets#deal'

  resources :owners
  resources :lotteries, param: :code
  resources :gifts  #  , param: :seq
  resources :tickets

  ### 開発用画面 ###
  # キャッシュをいじる
  # https://simple-lottery-sano400jp.c9users.io/cacheedit
  get  'devpages/cacheedit', to:'devpages#cacheedit'
  get  'devpages/setcache', to:'devpages#setcache'

end
