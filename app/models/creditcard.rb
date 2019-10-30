require 'payjp'
class Creditcard < ApplicationRecord
  belongs_to :user

  validates :credit_number, presence: true, format: {with: /\A(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6011[0-9]{12}|3(?:0[0-5]|[68][0-9])[0-9]{11}|3[47][0-9]{13})\z/}
  validates :limit_month, presence: true, format: {with: /\A[1-9]|[1-9][0-9]\z/}
  validates :limit_year, presence: true, format: {with: /\A[1-9]|[1-9][0-9]\z/}
  validates :security_number, presence: true, format: {with: /\A[0-9]{3,4}\z/}

  Payjp.api_key = Rails.application.credentials.dig(:payjp, :payjp_secret_key)

  # トークンを作成
  def create_token(credit_number, security_number, limit_month, limit_year)
    token = Payjp::Token.create({
      card: {
        number:    credit_number,
        cvc:       security_number,
        exp_month: limit_month,
        exp_year:  limit_year,
      }},
      {
        'X-Payjp-Direct-Token-Generate': 'true'
      } 
    )
    return token.id
  end

  # トークンで支払い
  def create_charge_by_token(token, amount)
    Payjp::Charge.create(
      amount:   amount,
      card:     token,
      currency: 'jpy'
    )
  end
end