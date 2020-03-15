class Item < ApplicationRecord
  # associations
  belongs_to    :brand,        optional: true
  belongs_to    :category
  belongs_to    :product_size, optional: true
  belongs_to    :shippingway,  optional: true


  has_many      :item_images , dependent: :destroy
  accepts_nested_attributes_for      :item_images

  belongs_to    :user
  belongs_to    :address
  has_many      :trades
  

  # enum
  enum condition_num:{ brand_new: 0, near_new: 1, no_dirt: 2, near_dirt:3 ,dirty:4, bad_condition:5 }
  enum daystoship_num:{one_to_two: 0, two_to_three:1, four_to_seven:2 }
  enum status_num:{exhibit: 0, sold_out:1, finished:2 }
end
