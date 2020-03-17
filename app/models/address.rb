class Address < ApplicationRecord
    # associations
    belongs_to    :area
    belongs_to    :user

    has_many      :items
    has_many      :trades
    
  
end
