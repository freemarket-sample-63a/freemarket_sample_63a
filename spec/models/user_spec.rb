require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    # # 1. nickname,email,first_name,last_name,first_name_kana,last_name_kana,birthday,telephone_numbeが存在すれば登録できること
    it "is valid with a nickname,email,first_name,last_name,first_name_kana,last_name_kana,birthday,telephone_number" do
      user = build(:user)
      expect(user).to be_valid

    end
    # 2. nicknameが空では登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    # 3. emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください", "は有効でありません。")
    end
    
    # 4. passwordが空では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください", "は7文字以上で入力してください", "は英字と数字両方を含むパスワードを設定してください")
    end

    # 5. passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("を入力してください")
    end

    # 6. last_nameが空では登録できないこと
    it "is invalid without a last_name" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください")
    end

    # 7. first_nameが空では登録できないこと
    it "is invalid without a first_name" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    # 8. last_name_kanaが空では登録できないこと
    it "is invalid without a last_name_kana" do
      user = build(:user, last_name_kana: nil)
      user.valid?
      expect(user.errors[:last_name_kana]).to include("を入力してください", "はカタカナで入力して下さい。")
    end

    # 9. first_name_kanaが空では登録できないこと
    it "is invalid without a first_name_kana" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください", "はカタカナで入力して下さい。")
    end

    # 10. birthdayが空では登録できないこと
    it "is invalid without a birthday" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end

    # 11. telephone_numberが空では登録できないこと
    it "is invalid without a telephone_number" do
      user = build(:user, telephone_number: nil)
      user.valid?
      expect(user.errors[:telephone_number]).to include("を入力してください", "は有効でありません。")
    end

    # 12. nicknameが16文字以上であれば登録できないこと
    it "is invalid with a nickname that has more than 15 characters " do
      user = build(:user, nickname: "1234567890123456")
      user.valid?
      expect(user.errors[:nickname]).to include("は15文字以内で入力してください")
    end





  end
end