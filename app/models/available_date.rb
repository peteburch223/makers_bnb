class Availabledate

  include DataMapper::Resource

  property :id,           Serial
  property :avail_date,   Date

  belongs_to :space
end
