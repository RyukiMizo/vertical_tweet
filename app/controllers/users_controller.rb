class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "俳句の世界へようこそ！"
      redirect_to @user
    else
      render 'edit'
      #@userの情報を引き継ぐ
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update_attribute(user_params)
      flash[:success] = "編集が完了しました！"
      redirect_to @user
    else
      flash.now[:danger] = "編集に失敗しました"
      render 'new'
    end
  end
  
  def destroy
    
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, )
  end
    
  def logged_in_user
    unless logged_in?
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
  
end