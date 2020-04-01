FactoryBot.define do

  factory :area, class: Area do

    name {"東京都"}

  end

  # 出品者地域 
  factory :seller_area, class: Area do

    name {"北海道"}

  end

  # 購入者地域 
  factory :buyer_area, class: Area do

    name {"東京都"}

  end

end