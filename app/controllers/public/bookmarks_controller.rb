class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    bookmark = @event.bookmarks.new(user_id: current_user.id)
    bookmark.save
    @event.create_notification_like!(current_user)
  end

  def destroy
    @event = Event.find(params[:event_id])
    bookmark = @event.bookmarks.find_by(user_id: current_user.id)
    bookmark.present?
    bookmark.destroy
  end
end
