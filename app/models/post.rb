class Post < ApplicationRecord
  
  has_many :comments ,dependent: :destroy
  has_many_attached :pics 
  has_rich_text :body
end
