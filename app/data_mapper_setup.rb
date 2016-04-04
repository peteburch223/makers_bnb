require 'data_mapper'
require 'dm-postgres-adapter'

require_relative './models/user'

connection_string = "postgres://localhost/makers_bnb_#{ENV['RACK_ENV']}"
DataMapper.setup(:default, ENV['DATABASE_URL'] || connection_string)
DataMapper::Logger.new($stdout, :debug)
# if ENV['RACK_ENV'] == 'test'
#     DataMapper
# end

DataMapper.finalize.auto_upgrade!
