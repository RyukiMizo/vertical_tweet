class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy


  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "アカウント確認メールを送りました。"
      redirect_to root_url
    else
      render 'edit'
      #@userの情報を引き継ぐ
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def index
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "編集が完了しました！"
      redirect_to @user
    else
      flash.now[:danger] = "編集に失敗しました"
      render 'new'
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end

  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, )
  end
    
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインが必要です"
      redirect_to login_url
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    if current_user != @user
      flash[:danger] = "不正なアクセスです"
      redirect_to root_url
    end
  end
  
  def admin_user
    @user = User.find(params[:id])
    unless current_user.admin? || current_user == @user
      flash[:danger] = "不正なアクセスです"
      redirect_to root_url
    end
  end
22
end