class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token #modelの外
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  PW_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}\z/i
  
  has_secure_password
  before_save {self.email = email.downcase}
  before_create :create_activation_digest
  
  validates :name, presence: true, length: {maximum: 10}
  
  validates :email, presence: true, length: {maximum: 255},
  format: {with: VALID_EMAIL_REGEX},
  uniqueness: {case_sensitive: false}
  validates :password,  length: {minimum: 6}, allow_nil: true, format: {with: PW_REGEX}
  validates :password_confirmation,  length: {minimum: 6},allow_nil: true, format: {with: PW_REGEX}
  
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  mount_uploader :image, ImageUploader
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
  
  def authenticated?(attribute,token)
    digest = self.send("#{attribute}_digest")#処理を途中で終了
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  private
  
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
    
    
  
end
