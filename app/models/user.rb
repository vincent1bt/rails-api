class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  field :name, type: String
  field :email, type: String
  field :password_digest, type: String
  
  has_secure_password

  validates :email, presence: true, email: true, uniqueness: true
  validates :name, presence: true
  validates :password_digest, presence: true

  has_many :posts
end
