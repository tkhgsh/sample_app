module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id #ブラウザ内に一時的にcookiesに暗号化済みのユーザIDを作成。後で取り出すことができる
    #ただし、ブラウザを閉じたら有効期限が終了
  end
  
  def current_user
      @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
