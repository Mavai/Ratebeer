class User < ActiveRecord::Base
  include RatingAverage
  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  has_secure_password
  validates :username, uniqueness: true, length: {minimum: 3, maximum: 30}
  validates :password, length: {minimum: 4}, format: {with: /([A-Z].*\d)|(\d.*[A-Z].*)/}

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    ratings.map { |r| r.beer.style }.uniq.sort_by { |style| average_rating_of_style(style) }.last
  end

  def favorite_brewery
    return nil if ratings.empty?
    ratings.map { |r| r.beer.brewery }.uniq.sort_by { |brewery| brewery.average_rating }.last
  end

  def self.top(n)
    User.all.sort_by { |user| -(user.ratings.count) }.first 3
  end
end
