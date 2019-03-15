class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:update, :edit]
  before_action :valid_user, only: [:update, :edit]
  before_action :check_expiration, only: [:update, :edit]
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:password_reset][:email])
    if user
      user.reset_token = User.new_token
      user.update_attribute(:reset_digest, User.digest(user.reset_token))
      user.update_attribute(:reset_sent_at, Time.zone.now)

      UserMailer.password_reset(user).deliver_now
      flash[:info] = "メールを送信しました"
      redirect_to root_url
    else
      flash[:danger] = "メールアドレスが見つかりません"
      render "new"
    end
  end

  def edit
  end
  
  def update
    #allow_nil: trueの対策をしなくてはならない。
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "更新完了！"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def get_user
    @user = User.find_by(email: params[:email])
  end
  
  def valid_user
    unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
      flash[:danger] = "不正なアクセスです。"
      redirect_to root_url
    end
  end
  

  def check_expiration
    if @user.reset_sent_at < 2.hours.ago
      flash[:danger] = "有効期限が切れています"
      redirect_to new_password_reset_url
    end
  end
  
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  
  
end
