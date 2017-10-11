class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]


  has_many :league_members
  has_many :leagues, :through => :league_members

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
    end
  end

  def is_part_of?(league)
    leagues.include?(league)
  end

  def stats(season)

    stats = { :games_won   => games_won(season).count,
              :games_lost  => games_lost(season).count,
              :games       => games(season).count,
              :points      => games_won(season).count * 3 + games_tied(season).count * 1,
              :ties        => games_tied(season).count }

    goals_for = 0
    goals_against = 0
    games(season).each do |game|
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
    season.games.where(:home_user => self.name, :approved => true, :winner => "Tie") +  season.games.where(:away_user => self.name, :approved => true, :winner => "Tie")
  end

  def games_lost(season)
     games(season) - games_tied(season) - games_won(season)
  end

  def review_needed
    Game.where({:reviewed => false, :reviewer => self.name})
  end
end
