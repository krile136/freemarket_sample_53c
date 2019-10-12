class Category < ApplicationRecord
  has_many :items
  has_ancestry
  scope :get_parents,  -> { where(ancestry: nil) }
end
