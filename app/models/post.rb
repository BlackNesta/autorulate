class Post < ApplicationRecord
  belongs_to :user
  has_many :user_favorite_cars, dependent: :destroy
  has_many :favorite_users, through: :user_favorite_cars, source: :user
  has_many_attached :images  
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { minimum: 3, maximum: 25 }
  validates :content, presence: true, length: { maximum: 140 }
  validates :images, content_type: { in: ['image/jpg', 'image/jpeg', 'image/png'], message: "must be a valid image format" }, 
                     size: { less_than: 5.megabytes, message: "should be less than 5MB" }
end
