class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    bookmark = @event.bookmarks.new(user_id: current_user.id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    bookmark = @event.bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?
        bookmark.destroy
        redirect_to request.referer
    else
        redirect_to request.referer
    end
  end
  
end
