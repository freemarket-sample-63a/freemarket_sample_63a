# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Userテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, index: true, unique: true|
|email|string|null: false, index: true, unique: true|
|encrypted_password|string|null: false|
|reset_password_token|string|index: true, unique: true|
|reset_password_sent_at|datetime||
|remember_created_at|datetime||
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birthday|date|null: false|
|telephone_number|string||
|self_image|string||
|self_introduction|text||

### Association

- has_many   :items
- has_many   :creditcards
- has_many   :addresses
- has_many   :trades

## Itemテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|address_id|references|null: false, foreign_key: true, index: true|
|brand_id|references|null: true, foreign_key: true, index: true|
|category_id|references|null: false, foreign_key: true, index: true|
|product_size_id|references|null: true, foreign_key: true, index: true|
|shippingway_id|references|null: true, foreign_key: true, index: true|
|condition_num|integer|null: false, limit: 1, unsigned: true, index: true|
|daystoship_num|integer|null: false, limit: 1, unsigned: true, index: true|
|title|string|null: false, index: true|
|description|text|null: false|
|price|decimal|null: false, precision: 10, scale: 3|
|feerate|decimal|null: false, precision: 4, scale: 3|
|profit_price|desimal|null: false, precision: 10, scale: 3|

### Association

- belongs_to    :address
- belongs_to    :brand, optional: true
- belongs_to    :category
- belongs_to    :product_size, optional: true
- belongs_to    :shippingway, optional: true
- belongs_to    :user
- has_one       :trade
- has_many      :item_images
- accepts_nested_attributes_for :item_images, allow_destroy: true

## Tradeテーブル

|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foreign_key: true, index: true|
|user_id|references|null: false, foreign_key: true, index: true|
|address_id|references|null: false, foreign_key: true, index: true|
|status_num|integer|null: false, limit: 1, unsigned: true|

### Association

- belongs_to    :item
- belongs_to    :user
- belongs_to    :address

## Areaテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association

- has_many :addresses

## Addressテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true, index: true|
|area_id|references|null: false, foreign_key: true, index: true|
|status_num|integer|null: false, limit: 1, unsigned: true|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|postal_number|string|null: false|
|city|string|null: false|
|number|string|null: false|
|building|string|null: true|
|telephone_number|string|null: false|

### Association

- belongs_to  :area
- belongs_to  :user
- has_many    :items
- has_many    :trades
  
## Creditcardテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true, index: true|
|card_id|string|null: false|
|customer_id|string|null: false|

### Association

- belongs_to :user

## Item_imageテーブル

|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foreign_key: true, index: true|
|image|string|null: false|

### Association

- belongs_to :item, optional: true
- mount_uploader :image, ImageUploader
  
## Shippingwayテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|ancestry|string|null: false, index: true|

### Association

- has_many :items
- has_ancestry

## Brandテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|

### Association

- has_many :items

## Catetgoryテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null:false, index: true|
|ancestry|string|index: true|

### Association

- has_many :items
- has_many :category_sizes
- has_many :product_sizes, through: :category_sizes
- has_ancestry

## Product_sizeテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null:false, index: true|
|ancestry|string|index: true|

### Association

- has_many :category_sizes
- has_many :categories, through: :category_sizes
- has_ancestry  

## Catetgory_sizeテーブル

|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foreign_key: true, index: true|
|product_size_id|references|null: false, foreign_key: true, index: true|

### Association

- belongs_to :category
- belongs_to :product_size
