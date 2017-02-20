class Brewery < ActiveRecord::Base
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  validates :name, presence: true
  validates :year, numericality: {greater_than_or_equal_to: 1042, :only_integer => true}
  validate :year_cannot_be_in_the_future
  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def print_report
    puts name
    puts "established at #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    this.year = 2017
    puts "changed year to #{year}"
  end

  def year_cannot_be_in_the_future
    if year.present? && year > Time.current.year
      errors.add(:year, "can't be in the future")
    end
  end

  def self.top(n)
    Brewery.all.sort_by { |b| -(b.average_rating) }.first n
  end
end
