class ApplicationController < ActionController::API
  include SessionsHelper
  include ActionController::Cookies
  rescue_from AuthenticationError, with: :render_unauthorized_error

  def render_unauthorized_error
    render json: { mesasge: 'unauthorized' }, status: :unauthorized
  end

  private

  # ログイン済みユーザーかどうかを確認
  def logged_in_user
    return if logged_in?

    redirect_to root_url
  end
end
