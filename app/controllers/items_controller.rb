class ItemsController < ApplicationController
  before_action :get_category_parents
  before_action :authenticate_user!, only: [:new, :buy]
  before_action :set_item, only: [:buy, :pay]

  def index
  end

  def show
  end

  def new
    @item = Item.new
    @image = @item.images.build
    5.times { @item.images.build }

  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '出品が完了しました'
    else
      redicret_to user_items_path, alert: '出品に失敗しました。必須項目を確認してください。'
    end
  end
  
  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  def buy
    @image_path = @item.images.first.image_path
    @delivery_address = current_user.delivery_address.decorate
    @creditcard = current_user.creditcards.first.decorate
  end

  def pay
    card = current_user.creditcards.first
    token = card.create_token(card.credit_number, card.security_number, card.limit_month, card.limit_year)
    card.create_charge_by_token(token, @item.price)
    
    @item.update(buyer_id: current_user.id)
    redirect_to root_path, notice: '購入が完了しました'
  end

  private
  def item_params
    params.require(:item).permit(
      :name, 
      :description, 
      :price, 
      :condition_id, 
      :postage_burden_id, 
      :delivery_method_id, 
      :category_id, 
      :size_id, 
      :prefecture_id, 
      :delivery_day_id, 
      :brand,
      :parent_id,
      :child_id,
      images_attributes: {image_url: []}
      ).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
