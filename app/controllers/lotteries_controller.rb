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
    @lottery.code = Digest::SHA1.hexdigest(@lottery.owner_code + @lottery.title + Time.now.strftime("%Y%m%M%H%d%S"))

    respond_to do |format|
      if @lottery.save
        format.html { redirect_to edit_lottery_path(@lottery) }
#        format.json { render :show, status: :created, location: @lottery }
      else
        format.html { render :new }
        format.json { render json: @lottery.errors, status: :unprocessable_entity }
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
      @lottery = Lottery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lottery_params
      params.require(:lottery).permit(:code, :owner_code, :title, :draw_time, :redraw_range, :nonres_redraw, :end_time)
    end
end