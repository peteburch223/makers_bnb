class Space
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, Text
  property :price, String

  belongs_to :user
  has n, :availabledates
  has n, :requests
end
