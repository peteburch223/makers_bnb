class Request
  include DataMapper::Resource

  property :id, Serial
  property :status, String
  property :request_id, Integer

  belongs_to :availabledate
  belongs_to :user
end
