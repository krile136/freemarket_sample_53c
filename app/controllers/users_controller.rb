class UsersController < ApplicationController
  before_action :get_category_parents
  before_action :set_user, only: [:show, :edit, :update, :show_creditcard]

  def new

  end

  def show
    @nickname = @user.nickname
  end

  def edit
    @nickname = @user.nickname
    @profile = @user.profile
  end

  def update
    if @user.id == current_user.id
      @user.update(user_edit_params)
      redirect_to edit_user_path(current_user), notice: 'プロフィールを変更しました'
    end
  end

  def identification

  end

  def show_creditcard
    @creditcards = @user.creditcards
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

  def list
    @items = Item.where(seller_id: params[:id]).order("id DESC")
    @images =  @items.map{|item| item.images[0].image_path}
  end

  private

  def user_edit_params
    params.permit(:nickname, :profile)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
