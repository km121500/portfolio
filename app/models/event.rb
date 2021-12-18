class Event < ApplicationRecord
  belongs_to :user
  has_many :event_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :event
  
  attachment :image
  
  # フォローフォロワー機能
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
  
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      Event.where(place: content)
    elsif method == 'forward'
      Event.where('place LIKE ?', content+'%')
    elsif method == 'backward'
      Event.where('place LIKE ?', '%'+content)
    else
      Event.where('place LIKE ?', '%'+content+'%')
    end
    
  end

end
