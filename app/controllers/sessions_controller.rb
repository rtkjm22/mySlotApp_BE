class SessionsController < ApplicationController
  def new
    user = User.all
    hoge = hoge('hogehoge')
    render json: hoge
  end

  def create
    token = TokenService.issue_by_password!(params[:email], params[:password])
    cookies[:token] = token
    render status: :created
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  # private
  #   def user_params
  #     params.require(:user).permit(:email, :passowrd, :password_confirmation)
  #   end
end
