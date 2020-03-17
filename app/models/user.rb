class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # associations

  has_many   :items
  has_many   :creditcards
  has_many   :addresses
  has_many   :trades

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d!@#\$%\^\&*\)\(+=._-]{7,20}\z/i
  VALID_KATAKANA_REGEX = /\A[\p{katakana}\p{blank}ー－]+\z/
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/

  validates :nickname,:last_name,:first_name, presence: true, length: { maximum: 15 }
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX, message: 'は有効でありません。' }
  validates :password, presence: true,confirmation:true, length: { in: 7..20 }, format: { with: VALID_PASSWORD_REGEX, message: 'は英字と数字両方を含むパスワードを設定してください'}
  validates :password_confirmation,:birthday, presence: true
  validates :last_name_kana,:first_name_kana,  presence: true, length: { maximum: 20 }, format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい。'}
  validates :telephone_number, presence: true, format: { with: VALID_PHONE_REGEX, message: 'は有効でありません。'}
end
