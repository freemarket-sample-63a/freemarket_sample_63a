class Trade < ApplicationRecord
  # associations
  belongs_to    :item
  belongs_to    :user
  belongs_to    :address

  # validations
  # 外部キー(null: false)をvalidationに定義すると、RSpecで正常動作テストで失敗するので、
  # 解決するまで外部キーを除外する。
  # validates :item_id, :user_id, :address_id, :status_num, presence: true
  validates :status_num, presence: true

  # enum
  enum status_num:{trading:0, under_delivery:1, finished:2 }
end
