class Availabledate
  include DataMapper::Resource

  has n, :requests

  property :id,           Serial
  property :avail_date,   Date

  belongs_to :space
end
