require 'json'
require 'mongo'

class MongoWrapper
  include Mongo

  def connection
    @connection ||= MongoClient.new('localhost', 27017)
  end

  def db
    @db ||= self.connection['mongo_ruby_demo']
  end

  # remove all non-built-in collections
  def clear
    self.db.collections.each do |coll|
      coll.remove unless coll.name.start_with?('system.')
    end
  end

  def checkin_seed_data
    # read in the dummy data
    json_str = File.read('./data/checkins.json')
    json = JSON.parse(json_str)
    json['response']['recent']
  end

  def seed
    users_coll = self.db['users']
    venues_coll = self.db['venues']
    checkins_coll = self.db['checkins']

    checkins = self.checkin_seed_data

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
  end
end

if __FILE__ == $0
  # file being run directly
  wrapper = MongoWrapper.new
  wrapper.clear
  wrapper.seed
end
