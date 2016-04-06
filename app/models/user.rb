require 'BCrypt'

class User
  include DataMapper::Resource
  attr_reader :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :email, String, format: :email_address, required: true, unique: true
  property :password_digest, Text

  validates_confirmation_of :password
  validates_length_of :password, min: 6

  has n, :requests
  # has n, :spaces

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = User.first(email: email)
    return user if user && BCrypt::Password.new(user.password_digest) == password
  end
end
