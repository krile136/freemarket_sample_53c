FactoryBot.define do
  factory :creditcard do
    credit_number           {"4123123412341234"}
    limit_month             {"12"}
    limit_year              {"23"}
    security_number         {"123"}
    association :user
  end
end