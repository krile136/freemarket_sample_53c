class ItemsController < ApplicationController
  before_action :get_category_parents

  def index
  end

  def show
    @item = Item.find_by(id: params[:id])
    # パスを保存する配列を宣言
    @image_path = []
    case Rails.env
    when "development"
      # 文字列操作をいっぺんにやるとエラーが出るので分割
      # 開発環境ではローカルのパスを生成する
      # オリジナルパス： @item.images[0].image_url[0].file.file
      @item.images.each do |img|
        path = img.image_url[0].file.file
        path.slice!(/.+(?=uploads)/)
        path.delete!('["')
        path.delete!(']"')
        path = "/" + path
        @image_path.push(path)
      end
    when "production"
      # 本番環境ではAWS S3のパスを生成する
      # オリジナルパス： @item.images[0].image_url[0].url
      @item.images.each do |img|
        path = img.image_url[0].url
        path.delete!('%5B%22')
        path.delete!('%22%5D"')
        @image_path.push(path)
      end
    end

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
