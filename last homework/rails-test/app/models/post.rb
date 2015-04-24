class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  validates_presence_of :title
  field :body, type: String
  field :clicks, type: Integer, default: 0

  scope :hottest, -> { where(:clicks.gt => 5).desc(:clicks) }

  field :replies_count, type: Integer, default: 0

  has_many :replies, dependent: :destroy
  belongs_to :author, class_name: "User"

  paginates_per 10
end
