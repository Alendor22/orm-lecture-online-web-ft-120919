require 'sqlite3'
require 'pry'

# set up a database connection...
DB = {}
DB[:conn] = SQLite3::Database.new "orm_lecture.db"
DB[:conn].results_as_hash = true

require_relative "../app/models/bird"
