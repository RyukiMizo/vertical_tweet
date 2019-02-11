require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before do
    @user = User.create(name: "a", email: "aa@aa.aa", 
          password: "aaaaaa", password_confirmation: "aaaaaa")
  end
    
  describe "search message" do
    before do
      @post1 = @user.posts.create(content: "Hello, World!")
      @post2 = @user.posts.create(content: "Hello, Space!")
      @post3 = @user.posts.create(content: "Hey, You!")
    end
      
    context "when term is found" do
      it "retuens posts that matche the search term" do
        expect(Post.search("hello")).to include(@post1, @post2)
        expect(Post.search("hello")).to_not include(@post3)
      end
    end
    
    context "when term is not found" do
      it "retuens empty when no results are found" do
        expect(Post.search("I")).to be_empty
      end
    end
    
  end
end
