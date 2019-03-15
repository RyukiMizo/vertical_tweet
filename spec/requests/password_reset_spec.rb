=begin
##各行の前でuser.reset_tokenを定義しないとエラーになる

require 'rails_helper'

RSpec.describe "パスワード再設定", type: :request do
  let(:user) { FactoryBot.create(:user) }
  context "formのメールアドレスが違う場合" do
    it "newに飛ぶ" do
      get new_password_reset_path
      post password_resets_path, params: {password_reset: {email: "aaaaad@sss@ss"}}#dbに存在していないメールアドレス
      expect(flash[:danger]).to be_truthy
      expect(response).to render_template(:new)
    end
  end
  context "formのメールアドレスが正しい場合" do
    it "rootに飛ぶ" do
      get new_password_reset_path
      post password_resets_path, params: {password_reset: {email: user.email}}
      expect(flash[:info]).to be_truthy
      expect(response).to redirect_to root_url
    end
  end
  
  describe "editにアクセスする" do
    context "reset_tokenが正しくない場合" do
      it "rootに飛ぶ" do
        post password_resets_path, params: {password_reset: {email: user.email}}
        #reset_digestとreset_tokenが作られる
        get edit_password_reset_url("wrong", email: user.email)
        expect(flash[:danger]).to be_truthy
        expect(response).to redirect_to root_url
      end
    end
    context "emailが正しくない場合" do
      it "rootに飛ぶ" do
        post password_resets_path, params: {password_reset: {email: user.email}}
        user = assigns(:user)
        get edit_password_reset_url(user.reset_token, email: "invalid@aa.aa")
        expect(flash[:danfer]).to be_truthy
        expect(response).to redirect_to root_url
      end
    end
    context "正しい情報の場合" do
      it "showに飛ぶ" do
        post password_resets_path, params: {password_reset: {email: user.email}}
        user = assigns(:user)
        get edit_password_reset_url(user.reset_token, email: user.email)
        expect(flash[:danger]).to be_falsely
      end
    end
  end
   
  describe "パスワードの変更について" do
    before do
      
      post password_resets_path, params: {password_reset: {email: user.email}}
      @user = assigns(:user)
      get edit_password_reset_url(@user.reset_token, email: @user.email)
      #メールアドレスの認証を終える
      
    end
    
    context "正しいパスワードを入力した時" do
      it "パスワードが変わる" do
        patch password_reset_path, params: {user: {password: "uuuuuu", password_confirmation: "uuuuuu"}}
        expect(flash[:success]).to be_truthy
        expect(response).to redirect_to user_path(@user)
        post login_path, params: {session: {email: @user.email, password: "uuuuuu"}}
        #ログインできる。
        expect(flash[:success]).to be_truthy
      end
    end
    context "パスワードが空の場合" do
      it "パスワードが変わらない" do
        patch password_reset_path, params: {user: {password: "", password_confirmation: ""}}
        expect(@user.errors[:password]).to be_present
        expect(response).to render_template 'edit'
      end
    end
    context "有効期限が切れている場合" do
      it "パスワードが変わらない" do
        @user.update_attribute(:reset_sent_at, 3.hours.ago)
        patch password_reset_path, params: {user: {password: "uuuuuu", password_confirmation: "uuuuuu"}}
        expect(flash[:danger]).to eq("有効期限が切れています")
        expect(response).to redirect_to new_password_reset_url
      end
    end
    it "2度目の変更はできない" do
      patch password_reset_path, params: {user: {password: "uuuuuu", password_confirmation: "uuuuuu"}}
      get edit_password_reset_url(@user.reset_token, email: @user.email)
      expect(flash[:danger]).to be_present
    end
  end
  
end

=end