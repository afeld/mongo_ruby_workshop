require 'json'
# docs: http://rubydoc.info/gems/mongo/1.8.4/frames
require 'mongo'

include Mongo


# connect to the DB
mongo = MongoClient.new('localhost', 27017)
db = mongo['mongo_ruby_demo']

# remove all non-built-in collections
db.collections.each do |coll|
  coll.remove unless coll.name.start_with?('system.')
end

users_coll = db['users']
venues_coll = db['venues']
checkins_coll = db['checkins']


# read in the dummy data
checkins = JSON.parse(File.read('./data/checkins.json'))['response']['recent']

# seed the DB
checkins.each do |checkin|
  # we don't want to keep the data embedded
  user = checkin.delete 'user'
  venue = checkin.delete 'venue'

  user_id = users_coll.insert user
  venue_id = venues_coll.insert venue

  # reference those newly-created documents
  checkin['user_id'] = user_id
  checkin['venue_id'] = venue_id

  checkins_coll.insert checkin
end

# just a sanity check
raise "not all checkins loaded" unless checkins.size == checkins_coll.count
