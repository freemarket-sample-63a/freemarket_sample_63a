FactoryBot.define do

  factory :address, class: Address do

    sequence(:city) { |i| "city_#{i}"}
    sequence(:number) { |i| "number_#{i}"}
    sequence(:building) { |i| "building#{i}"}

    association :area
    association :user

    trait :with_ladies_items do
      after(:build) do |address|
        address.items = []
        address.items << FactoryBot.build(:item, title: "ポーチ")
        address.items << FactoryBot.build(:item, title: "ダウンジャケット")
      end
    end

    trait :with_ladies_trades do
      after(:build) do |address|
        address.trades = []
        address.trades << FactoryBot.build(:trade, status_num: 1)
        address.trades << FactoryBot.build(:trade, status_num: 2)
      end
    end

  end

end