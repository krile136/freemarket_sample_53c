class ApplicationController < ActionController::Base
  def get_category_parents
    @category_parents = Category.get_parents
  end
end
