class Creditcard < ApplicationRecord
  belongs_to :user

  validates :credit_number, presence: true, format: {with: /\A(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6011[0-9]{12}|3(?:0[0-5]|[68][0-9])[0-9]{11}|3[47][0-9]{13})\z/}
  validates :limit_month, presence: true, format: {with: /\A[1-9]|[1-9][0-9]\z/}
  validates :limit_year, presence: true, format: {with: /\A[1-9]|[1-9][0-9]\z/}
  validates :security_number, presence: true, format: {with: /\A[0-9]{3}\z/}
end
