class PostsController < ApplicationController
  require 'nkf'
  #before_action :twitter_client, only: [:create]
  #attr_accessor :cont, :first, :k
  #include PostsHelper
  #before_action :twitter_client, only: :create
  #before_action :please_log_in, only: :create
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def home
    @post = current_user.posts.build if logged_in?
  end
  
  def index
    @posts = Post.all.paginate(page: params[:page])
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def create
    @post = current_user.posts.build(post_params)
    content = @post.content
    content = content.sub("https://vertical-tweet.herokuapp.com/", "").sub("#縦文字変換", "")
    content = NKF.nkf("-Xw",content)
    @post.content = content
    if @post.save
      flash[:success] = "投稿に成功しました！"
      redirect_to post_path(@post)
    else
      flash.now[:danger] = "エラーが発生しました。"
      render 'home'
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = "削除に成功しました！"
    redirect_to current_user
  end
  
  def search
    @posts = Post.where('content LIKE(?)', "%#{params[:keyword]}%")
    respond_to do |format|
      format.html {redirect_to posts_path(@posts.paginate(page: params[:page]))}
      format.json { render json: @posts.order('content ASC').limit(10) }
    end
  end
  
private

  def post_params
    params.require(:post).permit(:content)
  end
  
  def please_log_in
    unless logged_in?
      flash.now[:danger] = "投稿するためには登録が必要です。"
      render 'home'
    end
  end
  
  def correct_user
    @post = current_user.posts.find(params[:id])
    redirect_to root_url if @post.nil?
  end
end
