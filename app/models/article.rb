class Article < ApplicationRecord
  after_create :log_new_user
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  private
  def log_new_user
    puts "A new user was registered"
  end
end
