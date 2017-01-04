class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def stats
    stats = { :games_won   => games_won.count,
              :games_lost  => games_lost.count,
              :games       => games.count,
              :points      => games_won.count * 3 }

    goals_for = 0
    goals_against = 0
    games.each do |game|
      if game.home_user == self.name
        goals_for += game.home_score
        goals_against += game.away_score
      else
        goals_for += game.away_score
        goals_against += game.home_score
      end
    end

    stats[:goals_for] = goals_for
    stats[:goals_against] = goals_against
    stats
  end

  def games
    Game.where(:home_user => self.name, :reviewed => true) + Game.where(:away_user => self.name, :reviewed => true)
  end

  def games_won
    Game.where(:winner => self.name, :reviewed => true)
  end

  def games_lost
    games - games_won
  end

  def review_needed
    Game.where({:reviewed => false, :reviewer => self.name})
  end

  def self.name_list
    array = []
    User.all.each do |user|
      array.push(user.name)
    end

    array
  end
end
