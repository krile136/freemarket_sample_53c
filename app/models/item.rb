class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
    has_many :images, dependent: :destroy
    accepts_nested_attributes_for :images
    belongs_to_active_hash :prefecture
    belongs_to_active_hash :condition
    belongs_to_active_hash :postage_burden
    belongs_to_active_hash :delivery_day
    belongs_to_active_hash :delivery_method
    belongs_to_active_hash :size
    belongs_to :brand, optional: true
    belongs_to :category
    belongs_to :seller, class_name: 'User'
    belongs_to :buyer, class_name: 'User', optional: true

    validates :name, presence: true, length: { maximum: 40 }
    validates :description, presence: true, length: { maximum: 1000 }
    validates :price, presence: true, numericality: { only_integer: true , greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
    validates :condition_id, presence: true
    validates :postage_burden_id, presence: true
    validates :prefecture_id, presence: true
    validates :delivery_method_id, presence: true
    validates :category_id, presence: true
    validates :delivery_day_id, presence: true
    validates :parent_id, presence: true
    validates :child_id, presence: true
end
