class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String
  validates_presence_of :title, :body
  field :clicks, type: Integer, default: 0

  field :replies_count, type: Integer, default: 0

  has_many :replies, dependent: :destroy
  belongs_to :author, class_name: "User"

  paginates_per 10
end
