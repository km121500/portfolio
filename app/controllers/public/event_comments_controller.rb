class Public::EventCommentsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @comment = current_user.event_comments.new(event_comment_params)
    @comment.event_id = @event.id
    @comment.save
    @event.create_notification_comment!(current_user, @comment.id)
    redirect_to event_path(@event)
  end

  def destroy
    EventComment.find_by(id: params[:id]).destroy
    redirect_to event_path(params[:event_id])
  end
  
    private

  def event_comment_params
    params.require(:event_comment).permit(:comment)
  end
end
