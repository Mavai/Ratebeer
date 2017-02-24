class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      if user.blocked?
        redirect_to :back, notice: "Account frozen, plase contact an admin."
      else
        session[:user_id] = user.id if user
        redirect_to user, notice: 'Welcome back!'
      end
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

end