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

  describe Mongo::Collection do
    describe "#count" do
      it "should return the number of documents in the collection" do
        db['checkins'].count.must_equal 10
        db['users'].count.must_equal 10
        db['venues'].count.must_equal 10
      end
    end
  end
end
