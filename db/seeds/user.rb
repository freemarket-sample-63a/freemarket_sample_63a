ary_nickname = ["イチロー","ジロー","サブロー","シロー","ゴロー","ロクロー","ナナロー","ハチロー","クロー","ジューロー"]
ary_last_name = ["一","二","三","四","五","六","七","八","九","十"]
ary_last_name_kana = ["イチ","ジ","サブ","シ","ゴ","ロク","ナナ","ハチ","ク","ジュウ"]



10.times do |n|
  nickname  = ary_nickname[n]
  first_name = "鈴木"
  last_name = ary_last_name[n] + "郎"
  first_name_kana = "スズキ"
  last_name_kana = ary_last_name_kana[n] + "ロウ"
  birthday = Faker::Date.birthday(min_age: 0, max_age: 100)
  email = "example-#{n+1}@railstutorial.org"
  password = "pass1234"
  telephone_number = '12345678901'
  User.create!(
    nickname:  nickname,
    first_name: first_name,
    last_name: last_name,
    first_name_kana: first_name_kana,
    last_name_kana: last_name_kana,
    birthday: birthday,
    email: email,
    password:              password,
    password_confirmation: password,
    telephone_number: telephone_number
  )
end

