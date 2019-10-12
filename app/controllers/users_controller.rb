class UsersController < ApplicationController
  before_action :set_action_name

  def new
  end

  def show
  end

  def edit
    user = User.find(params[:id])
    @nickname = user.nickname
    @profile = user.profile
  end

  def update
    user = User.find(params[:id])
    if user.id == current_user.id
      user.update(user_edit_params)
      redirect_to "/users/#{current_user.id}/edit", notice: 'プロフィールを変更しました'
    end
  end

  def identification

  end

  def complete
  end

  private
  def set_action_name
    @action_name = action_name
  end

  def user_edit_params
    params.permit(:nickname, :profile)
  end
end
