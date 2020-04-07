FactoryBot.define do
  factory :item, class: Item do

    sequence(:title) { |i| "product_#{i}"}
    sequence(:description) { |i| "description_#{i}"}

    condition_num    {1}
    daystoship_num   {1}
    price            {1000.000}
    feerate          {0.100}
    profit_price     {900.000}

    association :brand
    association :category
    association :product_size
    association :shippingway
    association :address, factory: :seller_address
    user             {address.user}

  end
end