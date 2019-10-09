class Category < ApplicationRecord
  has_many :items
  has_many :category_sizes
  has_many :sizes, through: :category_sizes
  has_ancestry
  scope :get_parents,  -> { where(ancestry: nil) }
end
