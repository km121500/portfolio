class Public::SearchesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    @records = if @model == 'user'
      User.search_for(@content, @method)
    end
  end
end
