FactoryBot.define do

  factory :trade do
    status_num  {0}
    association :item
    association :address, factory: :buyer_address
    user        {address.user}
  end

end
