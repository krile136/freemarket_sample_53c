class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?

  def get_category_parents
    @category_parents = Category.get_parents
  end

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:nickname, :phone, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_year, :birth_month, :birth_day,
        delivery_address_attributes: [:delivery_last_name, :delivery_first_name, :delivery_last_name_kana, :delivery_first_name_kana, :delivery_postal_code, :prefecture_id, :delivery_city, :delivery_address, :delivery_building, :delivery_phone],
        creditcards_attributes: [:credit_number, :limit_month, :limit_year, :security_number],
        sns_credentials_attributes: [:uid, :provider]])
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def get_category_parents
    @category_parents = Category.get_parents
  end

  private

  def production?
    Rails.env.production?
  end
  
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
