ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

require_relative 'models/data_mapper_setup'
require_relative 'models/space'
require_relative 'server'
require_relative 'controllers/spaces'
require_relative 'controllers/users'
