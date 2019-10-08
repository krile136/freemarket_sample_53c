class ItemsController < ApplicationController
  before_action :get_category_parents

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
    @item = Item.create(item_params)
  end
  
  private
  def item_params
    params.require(:item).permit(
      :name, 
      :price, 
      :description, 
      :condition_id, 
      :fee_type, 
      :postage_burden_id, 
      :delivery_method, 
      :category_id, 
      :size_id, 
      :prefecture_id, 
      :delivery_day_id, 
      images_attributes: {image_url: []})
  end
end
