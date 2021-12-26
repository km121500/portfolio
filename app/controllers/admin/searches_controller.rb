class Admin::SearchesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    @records = (User.search_for(@content, @method) if @model == 'user')
  end
end
