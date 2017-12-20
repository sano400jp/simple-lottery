Rails.application.routes.draw do
  get 'guest/open_lottery'

  get 'guest/result'

  root 'pages#top'

  get '/lotteries', to:'lotteries#show'
  get '/lotteries/deal', to:'pages#deal'
  get '/lotteries/draw', to:'lotteries#draw'
  get '/q_deal_tickets', to:'tickets#quick_deal'
  post '/deal_tickets', to:'tickets#deal'

  resources :owners
  resources :lotteries, param: :code
  resources :gifts  #  , param: :seq
  resources :tickets

  ### 開発用画面 ###
  # キャッシュをいじる
  # https://simple-lottery-sano400jp.c9users.io/devpages/cacheedit
  get  'devpages/cacheedit', to:'devpages#cacheedit'
  get  'devpages/setcache', to:'devpages#setcache'

end
