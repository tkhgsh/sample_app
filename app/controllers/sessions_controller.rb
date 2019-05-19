class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #ユーザーログイン後にユーザー情報のページへリダイレクト
      log_in user
      redirect_to user #railsにより user_url(user)に変換、プロフィールページへ
    else
      flash.now[:danger]= 'メールとパスワードが違います'
      render 'new'
    end
  end
  
  #DELETE \logout
  def destroy
    log_out
    redirect_to root_url
  end
end
