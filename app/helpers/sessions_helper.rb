module SessionsHelper
  # 渡されたユーザーでログイン
  def log_in(user)
    session[:unique_id] = user.id
  end

  # 現在ログイン中のユーザーを返却（ユーザーが存在する場合）
  def current_user
    # @current_userが存在しない場合はUserから検索
    # find_byを使用しているのは、findだと例外が返ってきてしまう反面、find_byはnilが返却されるため
    @current_user ||= User.find_by(id: session[:unique_id])
  end

  # 受け取ったユーザーがログイン中のユーザーと一致すればtrueを返却
  def current_user?(user)
    user == current_user
  end

  # 現在のユーザーがログインしていればtrueを返却
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:unique_id)
    @current_user = nil
  end
end
