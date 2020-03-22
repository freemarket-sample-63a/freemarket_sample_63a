class Trade < ApplicationRecord
  # associations
  belongs_to    :item
  belongs_to    :user
  belongs_to    :address

  # validations
  validates :item_id, :user_id, :address_id, :status_num, presence: true

  # enum
  enum status_num:{trading:0, under_delivery:1, finished:2 }
end
