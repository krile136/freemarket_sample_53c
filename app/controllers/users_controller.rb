class UsersController < ApplicationController
  before_action :set_action_name
  before_action :get_category_parents

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

  def show_creditcard
    user = User.find(params[:id])
    @creditcards = user.creditcards
    if @creditcards.length > 0 
      # クレジットカード番号の先頭から12桁までを*に置換する
      @creditcards[0].credit_number = @creditcards[0].credit_number.sub(/[0-9]{12}/,"************")
      # クレジットカードの年の先頭から2桁を削除する（int型にしてしまったのでto_sで文字列に変換している）
      @creditcards[0].limit_year = @creditcards[0].limit_year.to_s.sub(/[0-9]{2}/,'')
    end
  end

  def new_creditcard
    
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
