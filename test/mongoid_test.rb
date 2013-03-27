require 'minitest/autorun'
require 'mongoid'
require_relative '../mongo_wrapper'

Mongoid.load! File.join(File.dirname(__FILE__), 'mongoid.yml'), :development


# define the models

class Checkin
  include Mongoid::Document
end

class User
  include Mongoid::Document
end

class Venue
  include Mongoid::Document
end


describe Mongoid do
  mongo = MongoWrapper.new

  before do
    # reset the data between each test
    mongo.clear
    mongo.seed
  end

  describe 'participant' do
    it "should return the number of documents in the collection" do
      Checkin.all.size.must_equal 10
      User.all.size.must_equal 10
      Venue.all.size.must_equal 10
    end

    it "should insert a new checkin" do
      user_id = User.first.id
      # simplified checkin
      checkin = Checkin.new(
        createdAt: Time.now.to_i,
        type: 'checkin',
        shout: "just testing"
      )

      checkin[:user_id] = user_id
      # pick an arbitrary venue
      checkin[:venue_id] = Venue.first.id

      checkin.save!

      Checkin.all.size.must_equal 11
      Checkin.where(user_id: user_id).size.must_equal 2
    end
  end
end
