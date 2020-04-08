class Item < ApplicationRecord
  # associations
  belongs_to    :address
  belongs_to    :brand,        optional: true
  belongs_to    :category
  belongs_to    :product_size, optional: true
  belongs_to    :shippingway,  optional: true
  belongs_to    :user

  has_one       :trade
  has_many      :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images, allow_destroy: true

  # enum
  enum condition_num:{ brand_new: 0, near_new: 1, no_dirt: 2, near_dirt: 3, dirty: 4, bad_condition: 5 }
  enum daystoship_num:{ one_to_two: 0, two_to_three: 1, four_to_seven: 2 }

  # validation
  validates :user_id,:address_id,:category_id,:shippingway_id, presence: true,numericality: true
  validates :condition_num,presence: true,inclusion: {in: self.condition_nums.keys}
  validates :daystoship_num,presence: true,inclusion: {in: self.daystoship_nums.keys}
  validates :title, presence: true, length: {maximum: 256}
  validates :description, presence: true, length: {maximum: 1000}
  validates :price,presence: true ,numericality: {greater_than_or_equal_to: 200,less_than:10000000}
  validates :profit_price,presence: true,numericality: {greater_than_or_equal_to: 0,less_than:10000000}
  validates :feerate,presence: true,numericality: {greater_than_or_equal_to: 0.001,less_than:1}
  validates :item_images,associated: true
end
