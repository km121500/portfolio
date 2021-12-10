class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(uer_params)
      flash[:success] = "会員情報を編集しました"
      redirect_to users_path(@user)
    else
      render "edit"
    end
  end

  def erasure
    
  end

  def leave
    @customer = User.find(user.id)
    if @user.update(is_delete: true)
      sign_out current_user
    end
    redirect_to user_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:email)
  end

end