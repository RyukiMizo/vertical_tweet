require 'rails_helper'

RSpec.describe User, type: :model do
  it "has valid factory_bot" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  
  describe "validation" do
    context "when form is empty" do
      it "is invalid without name." do
        user = FactoryBot.build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end
      it "is invalid without email." do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end
      
      it "is invalid without password."  do
        user = FactoryBot.build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end
    end
    
    context "email validation" do
  
      it "is invalid with a duplicated email and no distinction between upcase and downcase." do
        FactoryBot.create(:user, :normal_email)
        user = FactoryBot.build(:user,email: "AA@aa.aa")
        user.valid?
        expect(user.errors[:email]).to be_present
      end
      
      it "is invalid without @" do
        user = FactoryBot.build(:email_without_atmark)#factoryの内側
        user.valid?
        expect(user.errors[:email]).to be_present
      end
      it "is invalid without ." do
        user = FactoryBot.build(:user, :email_without_dot)#trait
      user.valid?
      expect(user.errors[:email]).to be_present
      end
    end
    
    context "password validation" do
      
    end
  end
  
  
end
