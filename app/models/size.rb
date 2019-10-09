class Size < ApplicationRecord
  has_many: items
  has_ancestry
  has_many :category_sizes
  has_many :categories, through: :category_sizes
end
