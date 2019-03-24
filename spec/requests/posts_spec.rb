require 'rails_helper'

RSpec.describe "Post", type: :request do
  
  context "ログインしていない時" do
    it "投稿できず、rootに飛ぶ" do
      get root_path
      ##session[:user_id] = nil
      post '/posts', params: {post: {content: "1"*16}}
      expect(flash[:danger]).to be_truthy
      expect(response).to redirect_to login_path
    end
  end

  context "ログインしている時" do
    it "投稿し、showに飛ぶ" do
      @user = FactoryBot.create(:user)
      log_in_as(@user)
      post '/posts', params: {post: {content: "1"*16}}
      expect(flash[:success]).to be_truthy
      post = @user.posts.last
      #直前に作ったpost
      expect(response).to redirect_to post_path(post)
    end
  end
  
  context "投稿に失敗した時" do
    it "投稿せず、rootに飛ぶ" do
      @user = FactoryBot.create(:user)
      log_in_as(@user)
      post '/posts', params: {post: {content: ""}}
      expect(flash[:danger]).to be_truthy
      expect(response).to render_template :home
    end
  end
  
end