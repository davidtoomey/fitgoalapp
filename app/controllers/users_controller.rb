class UsersController < ApplicationController

def show
  @user = current_user
  if @user.current_caloric_intake > @user.basal_metabolic_rate 
      @word = "more"
      @word2 = "gain"
      @word3 = "Gain"
    else
      @word = "fewer"
      @word2 = "burn"
      @word3 = "Burn"
    end
  if @user.rest_loss_gain == 1
    @day = "day"
  else 
    @day = "days"
  else
    @day = 'days'
  end
end


end