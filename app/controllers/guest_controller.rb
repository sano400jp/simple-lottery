class GuestController < ApplicationController
  def entry
    @guest_code = params[:guest_code]
    @token = params[:token]
  end

  def open_lottery
    guest_code = params[:guest_code]
    token = params[:token]
    # キャッシュにguest_code・tokenを登録
    # session[:ticket_token] = token
    # session[:guest_code] = guest_code

    # 抽選済みの場合
      # チケットのseqを取得
    @ticket = Ticket.find_by(guest_code: guest_code, token: token)
      # 抽選済みフラグを立てて伝搬
    # 未抽選の場合
      # 抽選済みフラグを折って伝搬

  end

  def result
    # paramsからguest_codeを取得
    # キャッシュからトークンを取得
    # lotteery_code 取得
    # gift_seq取得
    # 当たってたら
      # giftsレコードを取得
      # あたりフラグを立てて画面側に伝搬
    # 外れてたら
      # あたりフラグを折って画面側に伝搬
  end
end
