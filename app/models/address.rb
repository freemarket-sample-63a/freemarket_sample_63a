class Address < ApplicationRecord
    # associations
    belongs_to    :area
    belongs_to    :user

    has_many      :items
    has_many      :trades
    
    #REGEX
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_KATAKANA_REGEX = /\A[\p{katakana}]+\z/
    VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/

    # validation
    validates :first_name, :last_name, presence: true, length: { maximum: 15}
    validates :first_name_kana, :last_name_kana, presence: true, length: { maximum: 20}, format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力してください。'}
    validates :postal_number, presence: true, length: { is:7 }
    validates :area_id, :city, :number, presence: true
    #validates :telephone_number, format:{ with: VALID_PHONE_REGEX, message: 'は有効ではありません。'}


end
