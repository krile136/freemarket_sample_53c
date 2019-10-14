class Category < ApplicationRecord
  has_ancestry
  scope :get_parents,  -> { where(ancestry: nil) }

  def get_children
    self.children
  end
end