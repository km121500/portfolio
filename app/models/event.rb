class Event < ApplicationRecord
  belongs_to :user
  has_many :event_comment
  has_many :places,through: :event_places
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :event
  
  attachment :image
end
