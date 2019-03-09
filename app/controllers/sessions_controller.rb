class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])#formの内容が正しい場合
      if user.activated?#メールで有効かしているか否か
        remember(user)
        log_in(user)
        
        if params[:session][:remember_me] == 1
          remember(user)
        else
          forget(user)
        end
        
        redirect_back_or user
        flash[:sucess] = "ログインに成功しました！"
      else
        flash[:warning] = "アカウント認証のメールをご確認ください。"
        redirect_to root_url
      end
    else
      flash.now[:danger] = "メールアドレスかパスワードが正しくありません"
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
