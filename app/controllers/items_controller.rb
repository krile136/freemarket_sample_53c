class ItemsController < ApplicationController
  before_action :get_category_parents

  def index
  end

  def show
    @item = Item.find_by(id: params[:id])
    @image_path = @item.images.map{|img| img.image_path}
    @user = User.find(@item.seller_id)
    @category_parent = Category.find(@item.parent_id).name
    @category_child = Category.find(@item.child_id).name
    @category_grandchild = Category.find(@item.category_id).name
    @condition = Condition.find(@item.condition_id).name
    @postage_burden = PostageBurden.find(@item.postage_burden.id).name
    @delivery_method = DeliveryMethod.find(@item.delivery_method_id).name
    @prefecture = Prefecture.find(@item.prefecture_id).name
    @delivery_day = DeliveryDay.find(@item.delivery_day_id).name
    @price = @item.price_separate

    # ユーザーの他の商品
    @items = Item.where.not(id: @item.id).limit(6).order("id ASC")
    @prices = @items.map{|item| item.price_separate}
    @images = @items.map{|item| item.images[0].image_path}
  end

  def new
    @item = Item.new
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
end
