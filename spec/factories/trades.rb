FactoryBot.define do

  factory :trade do

    status_num  {0}

    association :item, factory: :sellitem
    association :address, factory: :buyaddress
    user        {address.user}

  end

end
