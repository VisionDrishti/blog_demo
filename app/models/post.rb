class Post < ApplicationRecord
  belongs_to :user
  has_many :comments ,dependent: :destroy
  has_many_attached :pics 
  has_rich_text :body
  has_many :likes, dependent: :destroy
  has_noticed_notifications model_name: 'Notification'
  has_many :notifications, through: :user
  belongs_to :category
  
  has_rich_text :body
  has_one :content, class_name: 'ActionText::RichText', as: :record, dependent: :destroy

end
