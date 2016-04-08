class Availabledate
  include DataMapper::Resource

  property :id,           Serial
  property :avail_date,   Date, lazy: false

  has n, :requests
  belongs_to :space
end
