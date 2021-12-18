class Public::UsersController < ApplicationController

  def index
    @user = User.find(params[:id])
    @events = @user.events.page(params[:page]).reverse_order
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "会員情報を編集しました"
      redirect_to users_path(@user)
    else
      render "edit"
    end
  end

  def erasure
    @user = User.find(params[:id])
  end

  def leave
    @user = User.find(user.id)
    if @user.update(is_delete: true)
      sign_out current_user
    end
    redirect_to user_path
  end

  def user_all
    @users = User.all
  end

  def calender
    @user = User.find(params[:id])
    @calenders = Calender.where(user_id: @user.id)
    @calender = Calender.new
    @events = []
    @events.push(
      title:'テスト',
      start:'2021-12-18',
      end:'2021-12-18'
    )
    @events.push(
      title:'テスト２',
      start:'2021-12-19',
      end:'2021-12-19'
    )
  end

  def bookmark
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name,:email)
  end

end
