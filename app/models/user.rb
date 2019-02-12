class User < ApplicationRecord
  attr_accessor :remember_token
  
  has_secure_password
  before_save {self.email = email.downcase}
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
  format: {with: VALID_EMAIL_REGEX},
  uniqueness: {case_sensitive: false}
  
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  #nvm use --delete-prefix v8.3.0
  #npm install -g heroku-cli
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  
end
