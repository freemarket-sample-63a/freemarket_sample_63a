FactoryBot.define do

  factory :item, class: Item do

    sequence(:title) { |i| "product_#{i}"}
    sequence(:description) { |i| "description_#{i}"}

    product_size_id  {1}
    shippingway_id   {3}
    condition_num    {1}
    daystoship_num   {1}
    price            {1000.000}
    feerate          {0.100}
    profit_price     {900.000}

    association :user
    association :address
    association :category

  end

  # tradeモデルテスト用
  factory :seller_item, class: Item do

    sequence(:title) { |i| "product_#{i}"}
    sequence(:description) { |i| "description_#{i}"}

    condition_num    {0}
    daystoship_num   {0}
    price            {1000.000}
    feerate          {0.100}
    profit_price     {900.000}

    association :category
    association :address, factory: :seller_address
    user             {address.user}

  end

end