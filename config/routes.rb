Rails.application.routes.draw do
  root 'pages#top'

  get '/lotteries', to:'lotteries#show'

  resources :owners
  resources :lotteries, param: :code
  resources :gifts

  ### 開発用画面 ###
  # キャッシュをいじる
  # https://simple-lottery-sano400jp.c9users.io/cacheedit
  get 'cacheedit', to:'devpages#cacheedit'

end
