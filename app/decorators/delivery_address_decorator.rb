class DeliveryAddressDecorator < Draper::Decorator
  delegate_all

  def postalcode_with_mark
    "〒#{object.delivery_postal_code}"
  end

  def full_name
    "#{object.delivery_last_name} #{object.delivery_first_name}"
  end

  def full_address
    if object.delivery_building == ""
      "#{object.prefecture.name} #{object.delivery_city} #{object.delivery_address}"
    else
      "#{object.prefecture.name} #{object.delivery_city} #{object.delivery_address} #{object.delivery_building}"
    end
  end
end
