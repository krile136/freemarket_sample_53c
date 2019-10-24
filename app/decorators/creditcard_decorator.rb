class CreditcardDecorator < Draper::Decorator
  delegate_all

  def masking_number
    "************#{object.credit_number.slice(12, 4)}"
  end

  def limit_year_and_month
    "#{sprintf("%02d", object.limit_month)} / #{object.limit_year % 100} "
  end

end
