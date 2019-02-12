require 'rails_helper'

RSpec.describe "UsersLoginApi", type: :request do
  it "sessions/newにアクセスできること" do
    get login_path
    expect(response).to have_http_status(:success)
  end
  
  describe "<sessino#new>" do
    context "ログインに失敗したとき" do
      it "flashメッセージをキャッチする" do
        get login_path
        post login_path, params: {session: {email: "", password: ""}}
        expect(response).to have_http_status(:success)
        expect(flash[:danger]).to be_truthy
        get root_path
        expect(flash[:danger]).to be_falsey
      end
    end
  end
end