FactoryBot.define do
  factory :user do
    nickname              {"katou"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    last_name             {"加藤"}
    first_name            {"正夫"}
    last_name_kana        {"カトウ"}
    first_name_kana       {"マサオ"}
    birth_year            {"2000"}
    birth_month           {"12"}
    birth_day             {"3"}
    phone                 {"09012345678"}
  end
end
