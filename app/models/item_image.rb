class ItemImage < ApplicationRecord
    # associations
    belongs_to :item , optional: true
    mount_uploader :image, ImageUploader

    validates :image,presence: true,format:{ with: /\/*(?i).jpeg|\/*(?i).jpg|\/*(?i).png/ }
end
