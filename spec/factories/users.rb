FactoryBot.define do

  factory :user, class: User do
    sequence(:nickname)        { |i| "テスト太郎_#{i}"}
    sequence(:email)           { |i| "kkk_#{i}@gmail.com"}
    password                   {"00000000a"}
    password_confirmation      {"00000000a"}
    last_name                  {"苗字太郎"}
    first_name                 {"名前太郎"}
    last_name_kana             {"ミョウジカナ"}
    first_name_kana            {"ナマエカナ"}
    birthday                   {"20190101"}
    telephone_number           {"1234567890"}
  end

  # tradeモデルテスト用 出品者 
  factory :seller, class: User do
    sequence(:nickname)        { |i| "出品者_#{i}"}
    sequence(:email)           { |i| "seller_#{i}@test.com"}
    password                   {"00000000b"}
    password_confirmation      {"00000000b"}
    last_name                  {"苗字太郎"}
    first_name                 {"名前太郎"}
    last_name_kana             {"ミョウジカナ"}
    first_name_kana            {"ナマエカナ"}
    birthday                   {"20190101"}
    telephone_number           {"1234567890"}
  end

  # tradeモデルテスト用 購入者 
  factory :buyer, class: User do
    sequence(:nickname)        { |i| "購入者_#{i}"}
    sequence(:email)           { |i| "byuer_#{i}@test.com"}
    password                   {"00000000c"}
    password_confirmation      {"00000000c"}
    last_name                  {"苗字太郎"}
    first_name                 {"名前太郎"}
    last_name_kana             {"ミョウジカナ"}
    first_name_kana            {"ナマエカナ"}
    birthday                   {"20190101"}
    telephone_number           {"1234567890"}
  end

end
