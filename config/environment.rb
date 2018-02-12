require 'bundler'

require_relative "../models/game.rb"
require_relative "../models/user.rb"

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
