class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def games
    Game.where(:home_user => self.name) + Game.where(:away_user => self.name)
  end

  def games_won
    Game.where(:winner => self.name)
  end

  def games_lost
    games - games_won
  end

  def review_needed
    Game.where(:reviewed => false)
  end

  def self.name_list
    array = []
    User.all.each do |user|
      array.push(user.name)
    end

    array
  end
end
