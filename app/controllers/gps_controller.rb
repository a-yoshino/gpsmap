class GpsController < ApplicationController
  before_action :set_gp, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:post]
  # GET /gps
  # GET /gps.json
  def index
    @gps = Gp.all
  end

  # GET /gps/1
  # GET /gps/1.json
  def show
  end

  # GET /gps/new
  def new
    @gp = Gp.new
  end

  # GET /gps/1/edit
  def edit
  end

  # POST /gps
  # POST /gps.json
  def create
    @gp = Gp.new(gp_params)

    accuracy = 0.000015 # 1.5m相当

    @gps = Gp.findNearPoints(@gp[:lat], @gp[:lon], accuracy)

    if @gps.length > 0 then
      text = <<-EOS
[お知らせ]もうガッコンポイントとして登録されてるよ！！
(#{@gp[:lat]}, #{@gp[:lon]}
      EOS
      channel = "#gakkon_regist"
      notify_to_slack(text, channel)
      format.json { render json: {message: "This Gakkkon Point has already registered!"} , status: :ok }
    end

    respond_to do |format|
      if @gp.save
        format.html { redirect_to @gp, notice: 'Gp was successfully created.' }
        format.json { render action: 'show', status: :created, location: @gp }
      else
        format.html { render action: 'new' }
        format.json { render json: @gp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gps/1
  # PATCH/PUT /gps/1.json
  def update
    respond_to do |format|
      if @gp.update(gp_params)
        format.html { redirect_to @gp, notice: 'Gp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gps/1
  # DELETE /gps/1.json
  def destroy
    @gp.destroy
    respond_to do |format|
      format.html { redirect_to gps_url }
      format.json { head :no_content }
    end
  end

  def getNearPoints
    @gps = Gp.findNearPoints(params[:lat], params[:lon], params[:acc])
    
    p @gps.length
    if @gps.length > 0 then
      text = "[注意]近くにガッコンポイントがあるよ！！"
      channel = "#gakkon"
      notify_to_slack(text, channel)
    end

    render json: @gps

  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gp
      @gp = Gp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gp_params
      params.require(:gp).permit(:lat, :lon)
    end

    def notify_to_slack(text, channel)

      Slack.chat_postMessage text: text, username: "GakkonBot", channel: channel
    end
end
