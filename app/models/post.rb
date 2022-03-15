class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images  
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { minimum: 3, maximum: 25 }
  validates :content, presence: true, length: { maximum: 140 }
end
