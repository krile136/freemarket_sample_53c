class ItemsController < ApplicationController
  before_action :get_category_parents

  def index
  end

  def show
    @item = Item.find(22)
    # 商品一覧を実装したら変更する
    # @item = Item.find(params[:id])
    @category_parent = Category.find(@item.parent_id).name
    @category_child = Category.find(@item.child_id).name
    @images = Image.where(item_id: '22')
    
    # @user_items = Item.where(seller_id: @item.seller_id).sample(6)
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