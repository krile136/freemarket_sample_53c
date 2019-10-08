class UsersController < ApplicationController
  before_action :set_action_name

  def new
  end

  def show
  end

  def complete
  end

  private
  def set_action_name
    @action_name = action_name
  end
end
