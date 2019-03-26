require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  describe "postのvalidation" do
    context "contentの長さが不正な場合" do
      it "正当でない" do
        post = @user.posts.build(content: nil)
        expect(post).to_not be_valid
        post = @user.posts.build(content: "a"*9)
        expect(post).to_not be_valid
        post = @user.posts.build(content: "a"*23)
        expect(post).to_not be_valid
        post = @user.posts.build(content: "a"*22)
        expect(post).to be_valid
      end
    end
    context "conetntが同じ場合" do
      it "正当でない" do
        post = @user.posts.create(content: "a"*16)
        post2 = @user.posts.new(content: "a"*16)
        expect(post2).to_not be_valid
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
      @user.posts.create(content: "1"*16)#２番目に作られた
      post = @user.posts.create(content: "2"*16)#３番目に作られた
      expect(post).to eq Post.first
    end
  end
  
  describe "userとの関連付け" do
    it "紐づいて削除される" do
      @user.posts.create(content: "1"*16)
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
    
  end
end
