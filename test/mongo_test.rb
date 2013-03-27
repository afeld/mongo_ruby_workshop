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
      checkin['venue_id'] = db['venues'].find_one['id']

      db['checkins'].insert checkin

      db['checkins'].count.must_equal 11
      db['checkins'].find(user_id: user_id).count.must_equal 2
    end
  end
end
