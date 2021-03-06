DB = 'makers_bnb'.freeze

require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-aggregates'

require_relative 'space'
require_relative 'user'
require_relative 'available_date'
require_relative 'request'

connection_string = "postgres://localhost/#{DB}_#{ENV['RACK_ENV']}"
# DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || connection_string)
DataMapper.finalize
