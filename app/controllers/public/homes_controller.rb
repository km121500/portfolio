class Public::HomesController < ApplicationController
  def top
    @events = Event.all.order(created_at: :desc)
  end
end
