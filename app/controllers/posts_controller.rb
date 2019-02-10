class PostsController < ApplicationController
  #before_action :twitter_client, only: [:create]
  #attr_accessor :cont, :first, :k
  #include PostsHelper
  #before_action :twitter_client, only: [:create]
  
  def home
    @post = Post.new
  end
  
end
