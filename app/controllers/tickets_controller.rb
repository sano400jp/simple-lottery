require "securerandom"
require "rubygems"
require "rqrcode"
class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def deal
    @deal_cnt = params['deal_cnt'].to_i
    lottery_code = session[:lottery_code]
    # seqの最大値を取得
    max_seq = Ticket.where(lottery_code: lottery_code).maximum(:seq)
    if max_seq.nil?
      max_seq = 0
    end
    # 繰り返し登録処理実行
    @deal_cnt.times do
      ### 登録値設定
      max_seq = max_seq + 1
      new_ticket = Ticket.new
      new_ticket.lottery_code = lottery_code
      new_ticket.seq = max_seq
      # テーブルを検索して結果が0になるまで繰り返し実行
      strToken = ""
      iStop = 0
      loop{
        iStop = iStop + 1
        strToken = SecureRandom.hex(4)
        if Ticket.where(lottery_code: lottery_code, token: strToken).blank?
          break
        end
        if iStop > 100 then
          strToken = "hoge"
          break
        end
      }
      new_ticket.token = strToken
      if new_ticket.save
      else
      end
    end
  end

  def quick_deal

    lottery_code = session[:lottery_code]
    ### レコード取得
    # seqの最大値を取得
    max_seq = Ticket.where(lottery_code: lottery_code).maximum(:seq)
    if max_seq.nil?
      max_seq = 0
    end
    max_seq = max_seq + 1 #次のseq

    ### くじ情報取得
    rec_lottery = Lottery.find_by(code: lottery_code)
    guest_code = rec_lottery.guest_code

    ### 登録値設定
    new_ticket = Ticket.new
    new_ticket.lottery_code = lottery_code
    new_ticket.guest_code = guest_code
    new_ticket.seq = max_seq

    # 一意のトークンを生成（テーブルを検索して結果が0になるまで繰り返し実行）
    strToken = ""
    iStop = 0
    loop{
      iStop = iStop + 1
      strToken = SecureRandom.hex(4)
      if Ticket.where(lottery_code: lottery_code, token: strToken).blank?
        break
      end
      if iStop > 100 then
        strToken = "hoge"
        break
      end
    }
    new_ticket.token = strToken
    if new_ticket.save
    else
    end

    # チケットのURLを作成
    @url_str = "https://simple-lottery-sano400jp.c9users.io/entry/" << guest_code << "/" << strToken
  end

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.where(lottery_code: session[:lottery_code])
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:lottery_code, :seq, :token, :gift_seq, :act_flg, :status)
    end
end
