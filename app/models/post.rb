class Post < ApplicationRecord
 belongs_to :user
 has_many :comments, dependent: :destroy
 has_many :likes, as: :likeable, dependent: :destroy
 has_one_attached :image
 scope :sssdf, ->{where(:title => "leptop")}
 
end
 