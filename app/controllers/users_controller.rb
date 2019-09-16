class UsersController < ApplicationController
  before_action :set_action_name

  def show
  end

  private
  def set_action_name
    @action_name = action_name
  end
end
