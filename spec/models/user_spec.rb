require 'rails_helper'

RSpec.describe User, type: :model do

  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  describe "is not saved" do
    it "without a password" do
      user = User.create username: "Pekka"

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "with a too short password" do
      user = User.create username: "Pekka", password: "S3c", password_confirmation: "S3c"

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "with a password containing only letters" do
      user = User.create username: "Pekka", password: "Secret", password_confirmation: "Secret"

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end


  describe "with a proper password" do
    let(:user) { FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do

      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user) { FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer: beer, user: user)

      
    end
  end
end
