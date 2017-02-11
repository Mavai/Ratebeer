require 'rails_helper'

RSpec.describe User, type: :model do

  it 'has the username set correctly' do
    user = User.new username: 'Pekka'

    expect(user.username).to eq('Pekka')
  end

  describe 'is not saved' do
    it 'without a password' do
      user = User.create username: 'Pekka'

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it 'with a too short password' do
      user = User.create username: 'Pekka', password: 'S3c', password_confirmation: 'S3c'

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it 'with a password containing only letters' do
      user = User.create username: 'Pekka', password: 'Secret', password_confirmation: 'Secret'

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end


  describe 'with a proper password' do
    let(:user) { FactoryGirl.create(:user) }

    it 'is saved' do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it 'and with two ratings, has the correct average rating' do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe 'favorite beer' do
    let(:user) { FactoryGirl.create(:user) }

    it 'has method for determining one' do
      expect(user).to respond_to(:favorite_beer)
    end

    it 'without ratings does not have one' do
      expect(user.favorite_beer).to eq(nil)
    end

    it 'is the only rated if only one rating' do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer: beer, user: user)
      expect(user.favorite_beer).to eq(beer)
    end

    it 'is the one with highest rating if several rated' do
      create_beers_with_rating(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)
      expect(user.favorite_beer).to eq(best)
    end
  end

  describe 'favorite style' do
    let(:user) { FactoryGirl.create(:user) }

    it 'has method for determining one' do
      expect(user).to respond_to(:favorite_style)
    end

    it 'without ratings does not have one' do
      expect(user.favorite_style).to eq(nil)
    end

    it 'is the only rated if only one rating' do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer: beer, user: user)
      expect(user.favorite_style).to eq(beer.style)
    end

    it 'is the one with highest average rating if several rated' do
      create_beers_with_style_and_rating(user, 'Lager', 10, 20, 15, 7, 9)
      create_beers_with_style_and_rating(user, 'Pale Ale', 25, 20, 4, 4, 4)
      create_beers_with_style_and_rating(user, 'Porter', 25, 24, 30, 4, 4)
      expect(user.favorite_style).to eq('Porter')
    end
  end

  describe 'favorite brewery' do
    let(:user) { FactoryGirl.create(:user) }

    it 'has method for determining one' do
      expect(user).to respond_to(:favorite_brewery)
    end

    it 'without ratings does not have one' do
      expect(user.favorite_brewery).to eq(nil)
    end

    it 'is the only rated if only one rating' do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer: beer, user: user)
      expect(user.favorite_brewery).to eq(beer.brewery)
    end

    it 'is the one with highest average rating if several rated' do
      worst = FactoryGirl.create(:brewery)
      best = FactoryGirl.create(:brewery2)
      create_beers_with_brewery_and_rating(user, worst, 10, 10, 20, 15)
      create_beers_with_brewery_and_rating(user, best, 15, 15, 20, 24)
      expect(user.favorite_brewery).to eq(best)
    end
  end

  def create_beer_with_rating(user, score)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score: score, beer: beer, user: user)
    beer
  end

  def create_beers_with_rating(user, *scores)
    scores.each do |score|
      create_beer_with_rating(user, score)
    end
  end

  def create_beer_with_style_and_rating(user, style, score)
    beer = FactoryGirl.create(:beer, style: style)
    FactoryGirl.create(:rating, score: score, beer: beer, user: user)
    beer
  end

  def create_beers_with_style_and_rating(user, style, *scores)
    scores.each do |score|
      create_beer_with_style_and_rating(user, style, score)
    end
  end

  def create_beer_with_brewery_and_rating(user, brewery, score)
    beer = FactoryGirl.create(:beer, brewery: brewery)
    FactoryGirl.create(:rating, score: score, beer: beer, user: user)
    beer
  end

  def create_beers_with_brewery_and_rating(user, brewery, *scores)
    scores.each do |score|
      create_beer_with_brewery_and_rating(user, brewery, score)
    end
  end
end
