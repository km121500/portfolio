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
      flash[:success] = '会員情報を編集しました'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def erasure
    @user = User.find(params[:id])
  end

  def leave
    @user = User.find(user.id)
    sign_out current_user if @user.update(is_delete: true)
    redirect_to user_path
  end

  def user_all
    @users = User.all
  end

  def bookmark
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image)
  end
end
