require "securerandom"

class LotteriesController < ApplicationController
  before_action :set_lottery, only: [:show, :edit, :update, :destroy]

  # GET /lotteries
  # GET /lotteries.json
  def index
    @lotteries = Lottery.all
  end

  # GET /lotteries/1
  # GET /lotteries/1.json
  def show
  end

  # GET /lotteries/new
  def new
    @lottery = Lottery.new
    @lottery.owner_code = session[:owner_code]
  end

  # GET /lotteries/1/edit
  def edit
  end

  # POST /lotteries
  # POST /lotteries.json
  def create
    @lottery = Lottery.new(lottery_params)
    @lottery.owner_code = session[:owner_code]

    # lottery_codeの作成
    strToken = ""
    iStop = 0
    loop{
      iStop = iStop + 1
      strToken = SecureRandom.hex(20)
      if Lottery.where(code: strToken).blank?
        break
      end
      if iStop > 100 then
        strToken = "hoge"
        break
      end
    }
    @lottery.code = strToken

    # gest_codeの作成
    strToken = ""
    iStop = 0
    loop{
      iStop = iStop + 1
      strToken = SecureRandom.hex(10)
      if Lottery.where(gest_code: strToken).blank?
        break
      end
      if iStop > 100 then
        strToken = "hoge"
        break
      end
    }
    @lottery.gest_code = strToken

    respond_to do |format|
      if @lottery.save
        format.html { redirect_to edit_lottery_path(@lottery) }
#        format.json { render :show, status: :created, location: @lottery }
        session[:lottery_code] = @lottery.code
      else
        format.html { render :new }
        format.json { render json: @lottery.errors, status: :unprocessable_entity }
      end
    end
  end

  ### 抽選実行ボタン
  def draw
    # 抽選実行処理起動（本体はヘルパー使うべきか？）
    run_draw
  end

  def run_draw
    # Giftsからコードと個数
    # giftsList = Gift.find_by(lottery_code: session[:lottery_code])

    # Gifts毎繰り返し
    Gift.where(lottery_code: session[:lottery_code]).find_each do |gift|
      seq = gift.seq
      cnt = gift.start_cnt

      # 景品の残り個数を取得
      rem_cnt = cnt - Ticket.where(lottery_code: session[:lottery_code], gift_seq: seq).count

      # ランダムで配列のindexを選ぶ
      winningTickets = Ticket.where(lottery_code: session[:lottery_code], status: "1").order("RANDOM()").limit(rem_cnt)

      if winningTickets.count == 0 then
      else
        # 当選配列のTickets.gift_seq（項目名後悔中。gift_codeにすべきだったか、、、）を更新
        winningTickets.each do |wt|
          wt.gift_seq = seq
        end
        winningTickets.update_all("gift_seq = " + seq.to_s + ", status = '2'")
      end
    end
  end
  
  # PATCH/PUT /lotteries/1
  # PATCH/PUT /lotteries/1.json
  def update
    respond_to do |format|
      if @lottery.update(lottery_params)
        format.html { redirect_to @lottery, notice: 'Lottery was successfully updated.' }
        format.json { render :show, status: :ok, location: @lottery }
      else
        format.html { render :edit }
        format.json { render json: @lottery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lotteries/1
  # DELETE /lotteries/1.json
  def destroy
    @lottery.destroy
    respond_to do |format|
      format.html { redirect_to lotteries_url, notice: 'Lottery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lottery
      @lottery = Lottery.find_by(code: params[:code])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lottery_params
      params.require(:lottery).permit(:code, :owner_code, :title, :draw_time, :redraw_range, :nonres_redraw, :end_time, :gest_code)
    end
end
