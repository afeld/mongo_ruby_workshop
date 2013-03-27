require 'minitest/autorun'
require_relative '../mongo_wrapper'

describe Mongo do
  mongo = MongoWrapper.new
  db = mongo.db

  before do
    # reset the data between each test
    mongo.clear
    mongo.seed
  end

  describe 'participant' do
    it "should return the number of documents in the collection" do
      num_checkins = 'TODO'
      num_users = 'TODO'
      num_venues = 'TODO'
      
      num_checkins.must_equal 10
      num_users.must_equal 10
      num_venues.must_equal 10
    end

    it "should insert a new checkin" do
      user_id = db['users'].find_one['_id']
      # simplified checkin
      checkin = {
        createdAt: Time.now.to_i,
        type: 'checkin',
        shout: "just testing"
      }

      # TODO assign the user_id

      # pick an arbitrary venue
      checkin['venue_id'] = db['venues'].find_one['id']

      # TODO insert the checkin

      db['checkins'].count.must_equal 11
      db['checkins'].find(user_id: user_id).count.must_equal 2
    end

    it "should find the checkins of the user's friends" do
      ## ignore this setup ##
      user_ids = db['users'].distinct(:_id)
      user_id =  user_ids.first
      db['users'].update({_id: user_id}, {'$set' => {friend_ids: user_ids.last(2)}})
      #######################
      
      user = 'TODO - retrive using the user_id'
      friend_ids = 'TODO - get the Array of friend_ids from the user'
      checkins = 'TODO - retrieve the checkins using the friend_ids'

      checkins.count.must_equal 2
    end
  end
end
