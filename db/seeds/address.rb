ary_last_name = ["一","二"]
ary_last_name_kana = ["イチ","ジ"]
ary_area_id = [13,12]
ary_postal_number = ["1500041","1500040"]
ary_number = ["１丁目１２−１６","１丁目１８−２"]
ary_building = ["アジアビル","フレーム神南坂"]

2.times do |n|
  user_id = n+1
  first_name = "鈴木"
  last_name = ary_last_name[n] + "郎"
  first_name_kana = "スズキ"
  last_name_kana = ary_last_name_kana[n] + "ロウ"
  area_id = ary_area_id[n]
  status_num = 0
  postal_number = ary_postal_number[n]
  city = "東京都渋谷区神南"
  number = ary_number[n]
  building = ary_building[n]
  telephone_number = "0312345678"
  Address.create!(user_id:          user_id,
    area_id:          area_id,
    first_name:       first_name,
    last_name:        last_name,
    first_name_kana:  first_name_kana,
    last_name_kana:   last_name_kana,
    status_num:       status_num,
    postal_number:    postal_number,
    city:             city,
    number:           number,
    building:         building,
    telephone_number: telephone_number)
end