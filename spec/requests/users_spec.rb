require 'rails_helper'

RSpec.describe "User", type: :request do
  describe "ユーザーの作成" do
    context "間違った情報の場合" do
      it "ユーザーは作られない" do
        expect {
          post users_path, params: {user: {name: "", email: "aa@aa.aa", password: "aaaaaa", password_confirmation: "aaaaaa"}}
        }.to_not change(User, :count)
      end
    end
    
    context "パスワードが空の場合" do
      it "ユーザーが作られない" do
        expect {
          post users_path, params: {user: {name:"aa", email: "aa@aa.aa", password: "", password_confirmation: ""}}
        }.to_not change(User, :count)
      end
    end
    
    context "正しい情報の場合" do
      it "ユーザーが作られる" do
        expect {
            post users_path, params: {user:{name: "aa", email: "aa@aa.aa", password: "aaaaaa", password_confirmation: "aaaaaa"}}
        }.to change(User, :count).by(1)
      end
    end
  end
  
  describe "アカウント有効化" do
    before do
      @user = FactoryBot.create(:no_activation)#activationが無効の状態でユーザーを作成する。
    end
    context "アカウントが有効化されていない場合" do
      it "ログインできない" do
        log_in_as(@user)
        expect(response).to redirect_to root_url
        expect(flash[:warning]).to be_truthy
        expect(session[:user_id]).to be_falsey
      end
    end
    context "トークンが不正な場合" do
      it "ログインできない" do
        get edit_account_activation_url("invalid", email: @user.email)
        expect(response).to redirect_to root_url
        expect(flash[:danger]).to be_truthy
        expect(session[:user_id]).to be_falsey
      end
    end
    context "メールアドレスが不正な場合" do
      it "ログインできない" do
        get edit_account_activation_url(@user.activation_token, email: "invalid")
        expect(response).to redirect_to root_url
        expect(flash[:danger]).to be_truthy
        expect(session[:user_id]).to be_falsey
      end
    end
    context "アカウントが有効化される場合" do
      it "ログインできる" do
        get edit_account_activation_url(@user.activation_token, email: @user.email)
        expect(response).to redirect_to user_url(@user)
        expect(flash[:success]).to be_truthy
        expect(session[:user_id]).to be_truthy
      end
    end
    
  end
end
