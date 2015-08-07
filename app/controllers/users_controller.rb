class UsersController < ApplicationController

def show
  @user = current_user
  if @user.current_caloric_intake > @user.basal_metabolic_rate 
      @word = "more"
      @word2 = "gain"
      @word3 = "Consume"
    else
      @word = "fewer"
      @word2 = "lose"
      @word3 = "Burn"
    end
  if @user.rest_loss_gain == 1
    @day = "day"
  else 
    @day = "days"
  end
end


end