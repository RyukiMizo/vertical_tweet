require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid without name." do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end
  it "is invalid without email." do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  
  it "is invalid without password."  do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
  
  it "is invalid with a duplicated email." do
    User.create(name: "a", email: "aa@aa.aa", 
                   password: "aaaaaa", password_confirmation: "aaaaaa")
    user = User.new(name: "a", email: "aa@aa.aa", 
                   password: "aaaaaa", password_confirmation: "aaaaaa")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  
  
end
