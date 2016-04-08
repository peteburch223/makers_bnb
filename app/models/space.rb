class Space
  include DataMapper::Resource

  property :id, Serial
  property :name, String, lazy: false
  property :description, Text, lazy: false
  property :price, String, lazy: false

  belongs_to :user
  has n, :availabledates
end
