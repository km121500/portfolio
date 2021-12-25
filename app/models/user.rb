class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :event_comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :group_users
  has_many :groups, through: :group_users

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  has_many :calenders, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :event

  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
  validates :name ,presence: { message: "は１文字以上入力してください。" }
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

  # 退会機能
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

  # 未読の通知が存在するか確認(チャット)
  def unchecked_chats?
    my_rooms_ids = UserRoom.select(:room_id).where(user_id: id)
    other_user_ids = UserRoom.select(:user_id).where(room_id: my_rooms_ids).where.not(user_id: id)
    Chat.where(user_id: other_user_ids, room_id: my_rooms_ids).where.not(checked: true).any?
  end

  # 　フォロー機能
  def create_notification_follow!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
