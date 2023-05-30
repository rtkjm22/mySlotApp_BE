require 'pry'
class UsersController < ApplicationController
  include Authenticatable
  before_action :authenticate_with_token!, except: %i[new create]

  def new
    @user = User.new
  end

  def create
    if User.find_by(email: params[:email])
      render json: { message: '同じメールアドレスが登録されています！' },
             status: :bad_request
    else
      @user = User.new(name: params[:name], email: params[:email], password: params[:password],
                       password_confirmation: params[:password_confirmation])
      if @user.save
        result = TokenService.issue_by_password!(params[:email], params[:password])
        cookies[:token] = { value: result[:token] }
        
        redirect_to controller: 'scores', action: 'new'
      else
        render :new
      end
    end
  end

  def show
    render json: { user: { id: current_user.id, name: current_user.name, email: current_user.email, unique_id: current_user.unique_id } },
           status: :ok
  end

  def edit
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    @user = User.find(params[:id])

    if current_user == @user
      if @user.update(user_params)
        render :edit
      else
        render :edit
      end
    else
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
