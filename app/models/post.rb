class Post
  include Mongoid::Document
  field :title, type: String
  field :body, type: String
  field :user_id, type: Integer

  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
end
