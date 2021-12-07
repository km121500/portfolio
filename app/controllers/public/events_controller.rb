class Public::EventsController < ApplicationController
  
  def index
    @events = Event.all
  end
  
  def new 
    @event = Event.find(id:params[:id])
    @event = Event.new
  end  
  
  def create
    @event = Event.find(id:params[:id])
    @event = Event.new(event_params)
    @event.save
    redirect_to events_path
  end
  
  private
  
  def event_params
    params.require(:event).permit(:title,:body,:place,:image_id)
  end
  
end
