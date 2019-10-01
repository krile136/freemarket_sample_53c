class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
    has_many :images, dependent: :destroy
    accepts_nested_attributes_for :images
    belongs_to_active_hash :prefecture
    belongs_to_active_hash :condition
    
    belongs_to :seller, class_name: 'User'
    belongs_to :buyer, class_name: 'User', optional: true
end
