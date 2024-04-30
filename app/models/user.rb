class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy
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