FactoryBot.define do

  factory :trade do

    status_num  {0}

    association :item, factory: :seller_item
    association :address, factory: :buyer_address
    user        {address.user}

  end

end
