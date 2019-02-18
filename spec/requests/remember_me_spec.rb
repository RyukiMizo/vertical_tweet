require 'rails_helper'

RSpec.describe "Cookieについて", type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  it "2つのウィンドウでログアウトできる" do
    log_in_as(@user)#ログイン
    expect(response).to redirect_to user_path(@user)
    delete logout_path#ログアウト
    expect(response).to redirect_to root_url
    expect(session[:user_id]).to eq nil
    
    delete logout_path#二度目のログアウト
    expect(response).to redirect_to root_url
    expect(session[:user_id]).to eq nil
  end

    
  describe "checkboxについて" do
    context "checkboxをつけたとき" do
      it "Cookieが存在する" do
        get login_path
        post login_path, params: {session: {email: @user.email, 
                                      password: @user.password, remember_me: "1"}}
        expect(cookies[:user_id]).present?
      end
    end 
    context "ceckboxを外したとき" do
      it "Cookieが存在しない" do
        get login_path
        post login_path, params: {session: {email: @user.email, 
                                      password: @user.password, remember_me: "0"}}
        expect(cookies[:user_id]).to be_empty
      end
    end
  end
end