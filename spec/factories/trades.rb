FactoryBot.define do

  factory :trade do

    status_num  {0}
    item_id     {1}
    user_id     {2}
    address_id  {2}

    association :item, factory: :sellitem
    association :address, factory: :buyaddress
    user        {address.user}

  end

end
