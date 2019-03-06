module LoginSupport
  def log_in_as(user)
    post '/login', params: {session: {email: user.email, password: user.password}}  
  end
  
  RSpec.configure do |config|
    config.include LoginSupport
  end
  
end