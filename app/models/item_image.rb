class ItemImage < ApplicationRecord
    # associations
    belongs_to :item , optional: true
    mount_uploader :image, ImageUploader
end
