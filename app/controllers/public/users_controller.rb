class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show,:user_all]
  
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
    @user = User.find(current_user.id)
    sign_out current_user if @user.update(is_deleted: true)
    redirect_to root_path
  end

  def user_all
    @users = User.all.order(created_at: :desc)
  end

  def bookmark
    @bookmarks = Bookmark.where(user_id: current_user.id).page(params[:page]).per(4)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image)
  end
end
