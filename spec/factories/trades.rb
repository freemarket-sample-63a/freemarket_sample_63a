FactoryBot.define do

  factory :trade do

    status_num         {0}

    association :item
    association :user
    association :address

  end

end
