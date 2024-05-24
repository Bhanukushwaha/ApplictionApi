class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :follows, dependent: :destroy #getting all followers of this user
  has_many :followings, class_name: "Follow", foreign_key: :current_user_id, dependent: :destroy #getting all followings of this user
  has_many :comments, dependent: :destroy
  # has_secure_password
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 },if: -> { new_record? || !password.nil? }
  
  def authenticate(password) 
    self.password == password
  end
  scope :first_name, -> {where('name = ?', 'bhanu')}
end