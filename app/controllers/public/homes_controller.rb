class Public::HomesController < ApplicationController
  def top
    @events = Event.all.order(created_at: :desc).page(params[:page]).per(12)
  end
end
