class UsersController < ApplicationController
  before_action :set_action_name
  before_action :get_category_parents

  def new
  end

  def show
  end

  private
  def set_action_name
    @action_name = action_name
  end
end
