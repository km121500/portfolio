class Admin::EventsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @events = Event.all.order(created_at: :desc)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end
end
