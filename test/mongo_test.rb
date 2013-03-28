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
      db['checkins'].count.must_equal 10
      db['users'].count.must_equal 10
      db['venues'].count.must_equal 10
    end

    it "should insert a new checkin" do
      user_id = db['users'].find_one['_id']
      # simplified checkin
      checkin = {
        createdAt: Time.now.to_i,
        type: 'checkin',
        shout: "just testing"
      }

      checkin['user_id'] = user_id
      # pick an arbitrary venue
      checkin['venue_id'] = db['venues'].find_one['_id']

      db['checkins'].insert checkin

      db['checkins'].count.must_equal 11
      db['checkins'].find(user_id: user_id).count.must_equal 2
    end

    it "should find the checkins of the user's friends" do
      ## ignore this setup ##
      user_ids = db['users'].distinct(:_id)
      user_id =  user_ids.first
      db['users'].update({_id: user_id}, {'$set' => {friend_ids: user_ids.last(2)}})
      #######################

      user = db['users'].find_one(_id: user_id)
      friend_ids = user['friend_ids']
      checkins = db['checkins'].find(user_id: {'$in' => friend_ids})
      checkins.count.must_equal 2
    end
  end
end
