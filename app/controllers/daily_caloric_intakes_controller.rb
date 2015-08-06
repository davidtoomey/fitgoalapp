class DailyCaloricIntakesController < ApplicationController
  before_action :set_daily_caloric_intake, only: [:show, :edit, :update, :destroy]

  # GET /daily_caloric_intakes
  # GET /daily_caloric_intakes.json
  def index
    @daily_caloric_intakes = DailyCaloricIntake.all
  end

  # GET /daily_caloric_intakes/1
  # GET /daily_caloric_intakes/1.json
  def show
  end

  # GET /daily_caloric_intakes/new
  def new
    @daily_caloric_intake = DailyCaloricIntake.new
  end

  # GET /daily_caloric_intakes/1/edit
  def edit
  end

  # POST /daily_caloric_intakes
  # POST /daily_caloric_intakes.json
  def create
    @daily_caloric_intake = DailyCaloricIntake.new(daily_caloric_intake_params)
    @daily_caloric_intake.user_id = current_user.id

    respond_to do |format|
      if @daily_caloric_intake.save
        format.html { redirect_to user_path(current_user), notice: 'Daily caloric intake was successfully created.' }
        format.json { render :show, status: :created, location: @daily_caloric_intake }
      else
        format.html { render :new }
        format.json { render json: @daily_caloric_intake.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_caloric_intakes/1
  # PATCH/PUT /daily_caloric_intakes/1.json
  def update
    respond_to do |format|
      if @daily_caloric_intake.update(daily_caloric_intake_params)
        format.html { redirect_to @daily_caloric_intake, notice: 'Daily caloric intake was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_caloric_intake }
      else
        format.html { render :edit }
        format.json { render json: @daily_caloric_intake.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_caloric_intakes/1
  # DELETE /daily_caloric_intakes/1.json
  def destroy
    @daily_caloric_intake.destroy
    respond_to do |format|
      format.html { redirect_to daily_caloric_intakes_url, notice: 'Daily caloric intake was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_caloric_intake
      @daily_caloric_intake = DailyCaloricIntake.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_caloric_intake_params
      params.require(:daily_caloric_intake).permit(:user_id, :calories)
    end
end
