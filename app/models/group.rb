class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  
  def self.search_for(content, method)
      Group.where('name LIKE ?', '%' + content + '%')
  end

  validates :name, presence: true
  validates :introduction, presence: true
  attachment :image, destroy: false
end
