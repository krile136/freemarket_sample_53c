FactoryBot.define do
  factory :item do
    id                    {nil}
    seller_id             {"1"}
    buyer_id              {nil}
    name                  {"testtesttest"}
    description           {"testtest"}
    price                 {"2000"}
    condition_id          {"1"}
    postage_burden_id     {"1"}
    delivery_method_id    {"1"}
    category_id           {"19"}
    size_id               {"1"}
    prefecture_id         {"1"}
    delivery_day_id       {"1"}
    parent_id             {"1"}
    child_id              {"7"}
  end
end