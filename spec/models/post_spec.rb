require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  describe "postのvalidation" do
    context "contentが空の時" do
      it "正当でない" do
        post = @user.posts.new(content: nil)
        expect(post).to_not be_valid
      end
    end
    context "user_idが空の時" do
      it "妥当でない" do
        post = Post.new(user_id: nil)
        expect(post).to_not be_valid
      end
    end
  end
  
  describe "postデータベース" do
    it "降順に登録される" do
      @user.posts.create(content: "one")
      post2 = @user.posts.create(content: "two")
      expect(post2).to eq Post.first
    end
  end
  
  describe "userとの関連付け" do
    it "紐づいて削除される" do
      @user.posts.create(content: "one")
      expect{
        @user.destroy
      }.to change(Post, :count).by(-1)
    end
  end
    
  describe "検索メッセージ" do
    before do
      @user = FactoryBot.create(:user)
      @post1 = @user.posts.create(content: "Hello, World!")
      @post2 = @user.posts.create(content: "Hello, Space!")
      @post3 = @user.posts.create(content: "Hey, You!")
    end
      
    context "文字列が見つかった場合" do
      it "一致した投稿を返す" do
        expect(Post.search("hello")).to include(@post1, @post2)
        expect(Post.search("hello")).to_not include(@post3)
      end
    end
    
    context "文字列が見つからない場合" do
      it "空を返す" do
        expect(Post.search("I")).to be_empty
      end
    end
    
  end
end
