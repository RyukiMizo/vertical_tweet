require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  it "FactoryBotが機能している" do
    expect(@user).to be_valid
  end
  
  describe "検証" do
    context "フォームが空の時" do
      it "名前が無くてはいけない" do
        @user.name = " "
        expect(@user).to_not be_valid
      end
      
      it "emailが無くてはいけない" do
        @user.email = " "
        expect(@user).to_not be_valid
      end
    end
    
    context "emailの検証" do
  
      it "重複してはいけない" do
        duplicate_user = @user.dup
        duplicate_user.email = " "
      end
      
      it "小文字でデータベースに保存されているか" do
        @user.email = "AAAA@Aaa.aAA"
        @user.save!
        expect(@user.reload.email).to eq "aaaa@aaa.aaa"
      end
      
      it "is invalid without @" do
        user = FactoryBot.build(:email_without_atmark)#factoryの内側
        user.valid?
        expect(user.errors[:email]).to be_present
      end
      it "is invalid without ." do
        user = FactoryBot.build(:user, :email_without_dot)#trait
      user.valid?
      expect(user.errors[:email]).present?
      end
      
    end
    
    context "パスワードの検証" do
      it "パスワードが6文字以上である" do
        @user.password = @user.password_confirmation = "a" * 5
        expect(@user).to_not be_valid
        
        @user.password = @user.password_confirmation = "a" * 6
        expect(@user).to be_valid
      end
      
      it "登録時に空ではいけない"do
        @user = FactoryBot.build(:user, password: nil)
        @user.password = @user.password_confirmation = nil
        expect(@user).to_not be_valid
      end

    end
    
    context "画像の検証" do
      it "" do
       
      end
    end
  end
end
