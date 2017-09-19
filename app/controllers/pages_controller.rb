class PagesController < ApplicationController
  def top
  end

  def deal
    # チケット枚数の取得
    @dealed_cnt = Ticket.where(lottery_code: session[:lottery_code]).size
    if @dealed_cnt.nil?
      @dealed_cnt = 0
    end
    # 
  end
end
