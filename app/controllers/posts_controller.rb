class PostsController < ApplicationController
  require 'nkf'
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
    @post.content = NKF.nkf("-Xw",@post.content)#大文字に変換
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
    if search_params[:keyword].blank?##空で検索した場合
      redirect_to posts_path
    else
      redirect_to search_index_post_path(search_params[:keyword])
    end
  end
  
  def search_js
    @posts2 = Post.where('content LIKE(?)', "%#{search_params[:keyword]}%").order('content ASC').limit(6)
  end
  
  def search_index
    @posts1 = Post.where('content LIKE(?)', "%#{params[:id]}%").order('content ASC').limit(10).paginate(page: params[:page])
  end
  
private

  def post_params
    params.require(:post).permit(:content)
  end
  
  def search_params
    params.permit(:keyword)
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
