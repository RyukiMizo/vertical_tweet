require 'rails_helper'

RSpec.describe "ログイン", type: :request do
  it "sessions/newにアクセスできること" do
    get '/login'
    expect(response).to have_http_status(:success)
  end
  
  describe "create" do
    context "パスワードが空の時" do
      it "ログインできない" do
        get '/login'
        post '/login', params: {session: {email: "aa@aa.aa", password: ""}}
        expect(flash[:danger]).to be_truthy
        get root_path
        expect(flash[:danger]).to be_falsey
      end
    end
  end
  
  describe "destroy" do
    before do
      @user = FactoryBot.create(:user)
    end
    
    it "ログアウトできているか" do
      get '/login'
      post '/login', params: {session: {email: @user.email, name: @user.name}}
      expect(response).to have_http_status "200"
      delete logout_path
      #follow_redirect!
      expect(response).to redirect_to(root_path)
    end
  end
      
      
end