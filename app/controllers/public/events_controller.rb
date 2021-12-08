class Public::EventsController < ApplicationController
  
  def index
    @events = Event.all
  end
  
  def new 
    @event = Event.new
  end  
  
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.save
    redirect_to events_path
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end
  
  private
  
  def event_params
    params.require(:event).permit(:title,:body,:image, places_attributes: [:content, :_destroy, :id])
  end
  
end
