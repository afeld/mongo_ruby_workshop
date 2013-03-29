require 'minitest/autorun'
require 'mongoid'
require_relative '../mongo_wrapper'

Mongoid.load! File.join(File.dirname(__FILE__), 'mongoid.yml'), :development


# TODO define the models for User, Venue and Checkin


describe Mongoid do
  mongo = MongoWrapper.new

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

    it "should insert a new checkin with foreign keys" do
      user_id = User.first.id

      # create a simplified checkin
      checkin_data = {
        createdAt: Time.now.to_i,
        type: 'checkin',
        shout: "just testing",

        user_id: user_id,
        venue_id: 'TODO - pick an arbitrary venue'
      }
      checkin = 'TODO - create the Checkin'

      Checkin.all.size.must_equal 11
      Checkin.where(user_id: user_id).size.must_equal 2
    end

    it "should insert a new checkin and assign relations" do
      user = User.first

      # simplified checkin
      checkin_data = {
        createdAt: Time.now.to_i,
        type: 'checkin',
        shout: "just testing"
      }
      checkin = 'TODO - create the Checkin'

      # TODO assign the User
      # TODO assign a Venue

      checkin.save!

      Checkin.all.size.must_equal 11
      Checkin.where(user_id: user.id).size.must_equal 2

      checkins = "TODO - retrieve the user's checkins"
      checkins.size.must_equal 2
      checkins.last.must_equal checkin
    end
  end
end
