module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if ratings.empty?
    (ratings.map { |r| r.score }.sum / ratings.count.to_f).round(2)
  end

  def average_rating_of_style (style)
    return 0 if ratings.empty?
    styles = ratings.find_all{|r| r.beer.style == style}.map{|r| r.score}
    (styles.sum / styles.count.to_f).round(2)
  end

end