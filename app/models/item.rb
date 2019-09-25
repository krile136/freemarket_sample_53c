class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture
    belongs_to_active_hash :condition
    
    belongs_to :seller, class_name: 'User'
    belongs_to :buyer, class_name: 'User', optional: true
end
