class SessionsController < ApplicationController
  layout false
 
  def new
  end
 
  def create
    @auth = request.env['omniauth.auth']['credentials']
    session[:user_id] = user.id
  end
end