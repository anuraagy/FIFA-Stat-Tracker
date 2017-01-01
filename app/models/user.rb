class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def games
    Game.where(:home_user => self.email) + Game.where(:away_user => self.email)
  end

  def games_won
    games.where(:winner => self.email)
  end

  def games_lost
    games - games_won
  end
end
