require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  it "retuens posts that matche the search term" do
    user = User.create(name: "a", email: "aa@aa.aa", 
          password: "aaaaaa", password_confirmation: "aaaaaa")
    post1 = user.posts.create(content: "Hello, World!")
    post2 = user.posts.create(content: "Hello, Space!")
    post3 = user.posts.create(content: "Hey, You!")
    
    expect(Post.search("hello")).to include(post1, post2)
    expect(Post.search("hello")).to_not include(post3)
  end

end
