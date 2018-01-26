class GuestController < ApplicationController
  def entry
    @guest_code = params[:guest_code]
    @token = params[:token]
  end

  def open_lottery
    guest_code = params[:guest_code]
    token = params[:token]
    # キャッシュにguest_code・tokenを登録
    session[:ticket_token] = token
    session[:guest_code] = guest_code

    # ステータス更新 0→1
    Ticket.where(:token => token, :guest_code => guest_code, :status => "0").update_all(:status => "1")

    # チケット情報取得
    @ticket = Ticket.find_by(guest_code: guest_code, token: token)

    @open_flg = "0"
    @msg = ""
    case @ticket.status
    when "0" then # 未エントリー　　　　※本来の操作でありえない
      @msg = "エントリーしてください"
    when "1" then # エントリー済み　　　※まだ抽選されていない
      @msg = "まだ抽選されていません"
    when "2" then # 抽選済みの場合　
      @open_flg = "1"
    when "3" then # 停止
      @msg = "無効なチケットです"
    end

  end

  def result
    ### 使う変数 ###
    # ▽アクティブレコード
    # @gift        # 景品情報格納用
    #
    # ▽ローカル変数
    # @hit_flg     # あたりフラグ
    #
    # ▽ローカル変数
    # guest_code   # チケット検索ゲストコード
    # token        # チケット検索用トークン
    # gift_seq     # 検索結果取得用景品連番


    # キャッシュからguest_code・トークンを取得
    token = session[:ticket_token]
    guest_code = session[:guest_code]
    # lotteery_code 取得
    # gift_seq取得
    gift_seq = Ticket.find_by(guest_code: guest_code, token: token).gift_seq
    # 外れてたら
    if gift_seq == 0 then
      # あたりフラグを折って画面側に伝搬
      @hit_flg = "0"
    else
    # 当たってたら
      # giftsレコードを取得
      @gift = Gift.joins("JOIN lotteries ON gifts.lottery_code = lotteries.code WHERE lotteries.guest_code = '" + guest_code + "'").first

      # あたりフラグを立てて画面側に伝搬
      @hit_flg = "1"
    end 

    @result = gift_seq
  end
end
