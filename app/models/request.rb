class Request
  include DataMapper::Resource

  property :id, Serial
  property :status, String

  belongs_to :availabledate
  belongs_to :user
  belongs_to :space
end
