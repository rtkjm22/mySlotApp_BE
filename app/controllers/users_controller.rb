class UsersController < ApplicationController
  include Authenticatable
  before_action :authenticate_with_token!

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
    render json: { user: { id: user.id, name: user.name, email: user.email } }, status: :ok
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
