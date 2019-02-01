class PostsController < ApplicationController
  #before_action :twitter_client, only: [:create]

  attr_accessor :cont
  include PostsHelper
  
  def new
    @post= Post.new
    con = Post.last.content.split("\r\n")
    #leng = con.length
    max_vert = con.map {|x| x.length}.max
    e = ""
    #縦に10行
    for width in (0..max_vert-1).to_a do
    #横に3行。
      for content in con.reverse do
      #["444","",3333","222","111",""]

        if content.empty? then
          e += "　"
          
        else
          one_char = content.split("")[width]
          #[4,4,4][0]
          if one_char then
            e += one_char
          else
            e += "　"
            
            #「あいうえお」の　「あ」
          end
        end
      end
      
      e += "\n"
      #１行終了
    end
    
    @cont = half_to_full(e)
  end

  def create
    @post = Post.new(post_params)
    
    if @post.save
      #\nで改行する
      #@post = @post.split("\n")
      redirect_to root_path
    else
      render 'new'
    end
  end


  private
  
  
  def post_params
    params.require(:post).permit(:content)
  end
'''
  def twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "自分のConsumer Keyを選択"
      config.consumer_secret = "自分のConsumer Secretを選択"
      config.access_token = "自分のAccess tokenを選択"
      config.access_token_secret ="自分のAccess token secretを選択"
    end
  end
'''
end

