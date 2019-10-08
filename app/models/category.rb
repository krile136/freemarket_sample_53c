class Category < ApplicationRecord
  has_ancestry
  scope :get_parents,  -> { where(ancestry: nil) }
end
