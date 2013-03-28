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

  # returns a cached copy
  def checkin_seed_data
    unless @checkin_seed_data
      # read in the dummy data
      json_str = File.read('./data/checkins.json')
      json = JSON.parse(json_str)
      @checkin_seed_data = json['response']['recent']
    end

    @checkin_seed_data
  end

  def add_checkin(checkin)
    # don't modify the hash
    checkin = checkin.dup

    # remove the embedded data
    user = checkin.delete('user').dup
    venue = checkin.delete('venue').dup

    # remove Foursquare-provided IDs, to be less confusing
    checkin.delete('id')
    user.delete('id')
    venue.delete('id')

    user_id = self.db['users'].insert user
    venue_id = self.db['venues'].insert venue

    # reference those newly-created documents
    checkin['user_id'] = user_id
    checkin['venue_id'] = venue_id

    self.db['checkins'].insert checkin
  end

  def seed
    checkins = self.checkin_seed_data

    checkins.each do |checkin|
      self.add_checkin checkin
    end

    # just a sanity check
    raise "not all checkins loaded" unless checkins.size == self.db['checkins'].count
  end
end

if __FILE__ == $0
  # file being run directly - reset the DB
  wrapper = MongoWrapper.new
  wrapper.clear
  wrapper.seed
end
