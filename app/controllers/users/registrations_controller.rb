# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
    @user = User.new(registration_params)
    @user.build_delivery_address
    @user.creditcards.build
    @user.sns_credentials.build
    @user.save
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end

  private
  def registration_params
    params.permit(:sign_up,
      keys: [:nickname, :phone, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_year, :birth_month, :birth_day,
        delivery_address_attributes: [:delivery_last_name, :delivery_first_name, :delivery_last_name_kana, :delivery_first_name_kana, :delivery_postal_code, :prefecture_id, :delivery_city, :delivery_address, :delivery_building, :delivery_phone],
        creditcards_attributes: [:credit_number, :limit_month, :limit_year, :security_number],
        sns_credentials_attributes: [:uid, :provider]])
  end
end
