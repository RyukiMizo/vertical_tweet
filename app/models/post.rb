class Post < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  
  has_many :likes, dependent: :destroy
  
  validates :user_id, presence: true
  validates :content, presence: true, length: {in: 10..22}, uniqueness: true
end
