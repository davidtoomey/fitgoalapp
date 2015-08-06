class UsersController < ApplicationController

def show
  @user = current_user
  if @user.current_caloric_intake > @user.basal_metabolic_rate 
      @word = "more"
      @word2 = "gain"
    else
      @word = "fewer"
      @word2 = "burn"
    end
  if @user.rest_loss_gain == 1
    @day = "day"
  end
end


end