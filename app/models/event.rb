class Event < ApplicationRecord
  belongs_to :user
  has_many :event_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :event
  has_many :notifications, dependent: :destroy
  has_many :tags, dependent: :destroy
  validates :title, presence: { message: 'は１文字以上入力してください。' }, length: { maximum: 20 }
  validates :image, presence:  { message: 'を選択してください。' }
  validates :date, presence: { message: 'は１文字以上入力してください。' }
  validates :place, presence: { message: 'は１文字以上入力してください。' }
  validates :body, presence: { message: 'は１文字以上入力してください。' }, length: { maximum: 200 }

  attachment :image

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Event.where(place: content)
    elsif method == 'forward'
      Event.where('place LIKE ?', content + '%')
    elsif method == 'backward'
      Event.where('place LIKE ?', '%' + content)
    else
      Event.where('place LIKE ?', '%' + content + '%')
    end
  end

  # 通知機能
  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(['visitor_id = ? and visited_id = ? and event_id = ? and action = ? ', current_user.id,
                               user_id, id, 'bookmark'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        event_id: id,
        visited_id: user_id,
        action: 'bookmark'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
    end
  end

  # コメントの通知機能
  def create_notification_comment!(current_user, event_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = EventComment.select(:user_id).where(event_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, event_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, event_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, event_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      event_id: id,
      event_comment_id: event_comment_id,
      visited_id: visited_id,
      action: 'event_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
