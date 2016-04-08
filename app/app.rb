puts "starting app"

ENV['RACK_ENV'] ||= 'development'

puts "RACK_ENV = #{ENV['RACK_ENV']}"

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require 'gon-sinatra'

require_relative 'helpers'
require_relative 'models/data_mapper_setup'
require_relative 'models/space'
require_relative 'models/available_date'
require_relative 'models/request'

require_relative 'server'
require_relative 'controllers/spaces'
require_relative 'controllers/users'
require_relative 'controllers/sessions'
require_relative 'controllers/requests'
