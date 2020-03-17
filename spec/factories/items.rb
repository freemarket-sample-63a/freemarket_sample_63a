FactoryBot.define do

  factory :item, class: Item do

    sequence(:title) { |i| "product_#{i}"}
    sequence(:description) { |i| "description_#{i}"}

    brand_id         {1}
    product_size_id  {1}
    shippingway_id   {3}
    price            {1000.000}
    feerate          {0.100}
    profit_price     {900.000}

    association :user
    association :address
    association :category

  end

end