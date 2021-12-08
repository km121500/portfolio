class Place < ApplicationRecord
  has_many :events, through: :event_places
end
