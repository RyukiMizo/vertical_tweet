class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  ##ここでincludeすることで、SessionHelper moduleが全てのコントローラーに適応される。
  
private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインが必要です"
      redirect_to login_url
    end
  end
end
