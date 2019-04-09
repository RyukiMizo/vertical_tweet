require 'rails_helper'

RSpec.describe "編集,削除", type: :request do
  before do
    @user = FactoryBot.create(:user)
  end
  
  describe "編集ページについて" do
    context "ログイン中のユーザーの時" do
      it "編集ページに行く" do
        log_in_as(@user)
        get edit_user_path(@user)
        expect(response).to have_http_status "200"
        #expect(flash[:success]).to be_truthy
      end
    end
      
    context "ログインしていないユーザーの時" do
      it "ログインページに行く" do
        get edit_user_path(@user)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to '/login'
        expect(flash[:danger]).to be_truthy
      end
    end
    
    context "別のユーザーのページに行く時" do
      it "ホームに行く" do
        other_user = FactoryBot.create(:user)
        log_in_as(other_user)
        get edit_user_path(@user)
        #get :edit, params: {id: @user.id}
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_path
      end
    end
    
  end
    
  describe "アップデートについて" do
    
    context "正しいユーザーの時" do
      it "アップデートする" do
        user_params = FactoryBot.attributes_for(:user, name: "bbb")
        log_in_as(@user)
        patch user_path(@user), params: {user: user_params}
        #id => /user/:id,  user => update情報
        expect(@user.reload.name).to eq "bbb"
      end
    end
    
    context "正しくないユーザーの時" do
      it "アップデートしない" do
        user_params = FactoryBot.attributes_for(:user, name: "bbb")
        other_user = FactoryBot.create(:user)

        log_in_as(other_user)
        patch user_path(@user), params: {user: user_params}
        expect(response). to redirect_to root_url
        expect(flash[:danger]).to be_truthy
      end
    end
    
    context "ログインしていないユーザーの時" do
      it "アップデートしない" do
        user_params = FactoryBot.attributes_for(:user, name: "bbb")
        patch user_path(@user), params: {user: user_params}
        expect(response). to redirect_to login_path
        expect(flash[:danger]).to be_truthy
      end
    end
    
    context "パスワードが空の時" do
      it "編集できる" do
        user_params = FactoryBot.attributes_for(:user, password: "", name: "bbb")
        patch user_path(@user), params: {user: user_params}
        expect(@user.reload.name).to eq "bbb"
      end
    end
    
    context "パスワードがnilの時" do
      it "編集できる" do
        user_params = FactoryBot.attributes_for(:user, password: nil, name: "bbb")
        patch user_path(@user), params: {user: user_params}
        expect(@user.reload.name).to eq "bbb"
      end
    end
        
  end
  
  describe "フレンドリーフォワーディング" do
    it "編集ページ=>ログイン" do
      get edit_user_path(@user)
      log_in_as(@user)
      expect(response).to redirect_to(edit_user_path(@user))
    end
  end
  
  describe "削除について" do
    context "正しいユーザーの時" do
      it "一人減る" do
        log_in_as(@user)
        expect {
          delete user_path(@user), params: {id: @user.id}
        }.to change(User, :count).by(-1)
      end
      it "indexに飛び、成功画面が表示" do
        log_in_as(@user)
        delete user_path(@user), params: {id: @user.id, }
        expect(response).to redirect_to users_url
        expect(flash[:success]).to be_truthy
      end
    end
    
    context "正しくないユーザーの時" do
      before do
        other_user = FactoryBot.create(:user)
        log_in_as(other_user)
      end
      it "数が減らない" do
        expect {
          delete user_path(@user), params: {id: @user.id}
        }.to change(User, :count).by(0)
      end
      it "rootに飛び、警告画面が表示" do
        delete user_path(@user), params: {id: @user.id}
        expect(response).to redirect_to root_url
        expect(flash[:danger]).to be_truthy
      end
    end
  end
  
  it "adminの編集を許可しない" do
    user_params = FactoryBot.attributes_for(:user, admin: true)
    log_in_as(@user)
    patch user_path(@user), params: {user: user_params}
    expect(@user.admin).to be_falsey
  end
  
  
end
