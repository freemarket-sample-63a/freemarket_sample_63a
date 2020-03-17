FactoryBot.define do

  factory :user do
    nickname              {"テスト太郎"}
    email                 {"kkk@gmail.com"}
    password              {"00000000a"}
    password_confirmation {"00000000a"}
    last_name             {"苗字太郎"}
    first_name            {"名前太郎"}
    last_name_kana        {"ミョウジカナ"}
    first_name_kana       {"ナマエカナ"}
    birthday              {"20190101"}
    telephone_number      {"1234567890"}

end