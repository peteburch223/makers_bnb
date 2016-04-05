class Space
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, Text
  property :price, String

  has n, :availabledates
end
