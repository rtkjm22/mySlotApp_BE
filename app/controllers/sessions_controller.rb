require 'pry'
class SessionsController < ApplicationController
  def new; end

  def create
    result = TokenService.issue_by_password!(params[:email], params[:password])
    log_in(result[:user])
    cookies[:token] = { value: result[:token] }
    render json: { userInfo: result[:user] }, status: :created,
           headers: {
             'Access-Control-Allow-Origin': 'http://localhost:3000',
             'Access-Control-Allow-Credentials': 'true'
           }
  end

  def destroy
    log_out if logged_in?
    render json: { message: 'ログアウトが完了しました。' }, status: :ok
  end
end
