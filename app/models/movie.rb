class Movie < ActiveRecord::Base
  @@all_ratings = {'G' => 'G', 'PG' => 'PG', 'PG-13' => 'PG-13', 'R' => 'R'}

  def self.all_ratings; @@all_ratings; end
end
