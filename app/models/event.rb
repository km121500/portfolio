class Event < ApplicationRecord
  belongs_to :user
  has_many :event_comment
  has_many :places,through: :event_places
  accepts_nested_attributes_for :places, allow_destroy: true
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

end
