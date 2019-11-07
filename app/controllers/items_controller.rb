class ItemsController < ApplicationController
  before_action :get_category_parents
  before_action :authenticate_user!, only: [:new, :buy]
  before_action :set_item, only: [:buy, :pay]

  def index
    @items = Item.order('id DESC').limit(10)
    @prices = @items.map{|item| item.price_separate}
    @images = @items.map{|item| item.images[0].image_path}

    # parent = Item.group(:parent_id).order('count_parent_id DESC').limit(4).count(:parent_id).keys
    parent = Category.where("id < ?", 5).limit(4)
    
    @ladies = Item.where(parent_id: parent[0]).order('id DESC').limit(10)
    @ladies_prices = @ladies.map{|item| item.price_separate}
    @ladies_images = @ladies.map{|item| item.images[0].image_path}

    @mens = Item.where(parent_id: parent[1]).order('id DESC').limit(10)
    @mens_prices = @mens.map{|item| item.price_separate}
    @mens_images = @mens.map{|item| item.images[0].image_path}

    @interiors = Item.where(parent_id: parent[2]).order('id DESC').limit(10)
    @interiors_prices = @interiors.map{|item| item.price_separate}
    @interiors_images = @interiors.map{|item| item.images[0].image_path}

    @babies = Item.where(parent_id: parent[3]).order('id DESC').limit(10)
    @babies_prices = @babies.map{|item| item.price_separate}
    @babies_images = @babies.map{|item| item.images[0].image_path}
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

  def destroy
    item = Item.find(params[:id])
    if item.seller_id == current_user.id
      if item.destroy
        redirect_to list_user_path(current_user), notice: '商品を削除しました'
      else
        redirect_to myitem_user_item_path(current_user, item.id), alert: '商品を削除できませんでした。'
      end
    else
      redirect_to myitem_user_item_path(current_user, item.id), alert: '商品を削除できません。ユーザー情報が間違っています'
    end
    
  end

  def edit
    @item = Item.find(params[:id])
    @image_path = @item.images.map{|img| img.image_path}
    (5 - @item.images.count).times { @item.images.build }
    @category_children = Category.where(ancestry: @item.parent_id)
    @category_grandchildren = Category.where(ancestry: "#{@item.parent_id}"+"/"+"#{@item.child_id}")
  end

  def update
    @item = Item.find_by(id: params[:id])
    if @item.update(item_params)
      redirect_to root_path ,notice: '商品を編集しました'
    else
      redicret_to edit_item_path, alert: '編集に失敗しました。必須項目を確認してください。'
    end
  end

  def myitem
    @item = Item.find(params[:id])
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
    # トークン作成
    token = card.create_token(card.credit_number, card.security_number, card.limit_month, card.limit_year)
    # トークン作成時にエラーが発生したら処理を終了する
    if token.match(/\[ERROR\].*/)
      redirect_to buy_item_path(@item), alert: token
      return
    end

    # 支払
    message = card.create_charge_by_token(token, @item.price)
    # 支払処理中にエラーが発生したら処理を終了する
    if message.match(/\[ERROR\].*/)
      redirect_to buy_item_path(@item), alert: message
      return
    end
    
    if @item.update(buyer_id: current_user.id)
      redirect_to root_path, notice: '購入が完了しました'
    else
      edirect_to buy_item_path(@item), alert: '購入に失敗しました。サポートにお問合せください'
    end
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
        images_attributes: [:id, {image_url: []}, :_destroy]
      ).merge(seller_id: current_user.id)
  end 

  def set_item
    @item = Item.find(params[:id])
  end
end
