class CategoriesController < ApplicationController
  def set_children
    @children = Category.find(params[:parent_id]).get_children
    respond_to do |format|
			format.json
		end
  end
end
