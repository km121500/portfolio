class Public::SearchesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'user'
      @records = User.search_for(@content, @method)
    elsif @model == 'event'
      @records = Event.search_for(@content, @method)
    else
      @records = Group.search_for(@content, @method)
    end
  end

end
