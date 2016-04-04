DB = 'makers_bnb'

require 'data_mapper'
require 'dm-postgres-adapter'
require 'bcrypt'

require_relative 'space'


connection_string = "postgres://localhost/#{DB}_#{ENV['RACK_ENV']}"
DataMapper.setup(:default, ENV['DATABASE_URL'] || connection_string)
DataMapper::Logger.new($stdout, :debug)
if ENV['RACK_ENV'] == 'test'
    DataMapper.auto_migrate!
end

DataMapper.finalize
