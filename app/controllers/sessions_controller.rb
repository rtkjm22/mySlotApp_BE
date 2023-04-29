class SessionsController < ApplicationController
  def new; end

  def create
    result = TokenService.issue_by_password!(params[:email], params[:password])

    cookies[:token] = { value: result[:token] }
    render json: { userInfo: result[:user] }, status: :created,
           headers: {
             'Access-Control-Allow-Origin': 'http://localhost:3000',
             'Access-Control-Allow-Credentials': 'true'
           }
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
