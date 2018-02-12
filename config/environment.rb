require 'bundler'

# require_relative "../lib/models/game.rb"
# require_relative "../lib/models/user.rb"
# require_relative "../lib/models/api.rb"

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
