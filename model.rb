#model.rb

require 'dm-core'
require 'dm-migrations'

class Spooner
  include DataMapper::Resource
  property :id, Serial
  property :username, String
  property :email, String
  property :profile_img, String
  property :password, String
  property :created_on, Date
  property :total_score, Integer
  property :played_sessions, Integer
  property :sessions_won, Integer
  property :score, Integer
  property :confirmed_hits, Integer
  property :active_session, Integer
  property :current_target, Integer
  property :active, Boolean
  property :status, String
  property :is_mod, Boolean
  has n, :sessions
end

class Session
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :created_on, Date
  property :start_on, Date
  property :end_on, Date
  property :active, Boolean
  property :status, String
  property :victor, Integer
  belongs_to :spooner
end

DataMapper.finalize

# configure :development do
#   DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
# end

# configure :production do
#   DataMapper.setup(:default, ENV['DATABASE_URL'])
# end

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

