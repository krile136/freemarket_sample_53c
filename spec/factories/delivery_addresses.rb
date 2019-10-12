FactoryBot.define do
  factory :delivery_address do
    delivery_last_name            {"加藤"}
    delivery_first_name           {"正男"}
    delivery_last_name_kana       {"カトウ"}
    delivery_first_name_kana      {"マサオ"}
    delivery_postal_code          {"123-4567"}
    prefecture_id                 {"1"}
    delivery_city                 {"X市"}
    delivery_address              {"Y番"}
    association :user
  end
end