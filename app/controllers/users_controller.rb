require 'pry'
class UsersController < ApplicationController
  include Authenticatable
  before_action :authenticate_with_token!, except: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render :new
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
    params.require(:user).permit(:name, :email, :passowrd, :password_confirmation)
  end
end
