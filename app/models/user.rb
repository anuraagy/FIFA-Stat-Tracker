class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :league_members
  has_many :leagues, :through => :league_members

  def stats(season)

    stats = { :games_won   => games_won(season).count,
              :games_lost  => games_lost(season).count,
              :games       => season.games.count,
              :points      => games_won(season).count * 3 + games_tied(season).count * 1,
              :ties        => games_tied(season).count}

    goals_for = 0
    goals_against = 0
    season.games.each do |game|
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

  def leagues_owned 
    leagues.where("league_members.role = ?", "commissioner")
  end

  def games(season)
    season.games.where(:home_user => self.name, :approved => true) + season.games.where(:away_user => self.name, :approved => true)
  end

  def games_won(season)
    season.games.where(:winner => self.name, :approved => true)
  end

  def games_tied(season)
    season.games.where(:home_user => self.name, :approved => true, :winner => "Tie") + season.games.where(:away_user => self.name, :approved => true, :winner => "Tie")
  end

  def games_lost(season)
    season.games - games_tied(season) - games_won(season)
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
