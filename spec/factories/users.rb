FactoryBot.define do

  factory :user, class: User do
    sequence(:nickname) { |i| "イチロー_#{i.to_s.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')}"}
    sequence(:email) { |i| "user_#{i}@test.co.jp"}
    sequence(:password) { |i| "password#{i}"}
    sequence(:password_confirmation) { |i| "password#{i}"}
    sequence(:first_name) { |i| "イチロー_#{i.to_s.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')}"}
    sequence(:last_name) { |i| "イチロー_#{i.to_s.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')}"}
    first_name_kana  {"イチロー"}
    last_name_kana   {"イチロー"}
    telephone_number {"09012345678"}
    birthday         {"1971/01/01"}
  end

end