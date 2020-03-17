require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do

    # ----空ではない場合に登録ができること----
    # # 1. nickname,email,first_name,last_name,first_name_kana,last_name_kana,birthday,telephone_numbeが存在すれば登録できること
    it "is valid with a nickname,email,first_name,last_name,first_name_kana,last_name_kana,birthday,telephone_number" do
      user = build(:user)
      expect(user).to be_valid
    end

    # ----空の場合に登録ができないこと----
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

    # ----nicknameに関するテスト----
    # 12. nicknameが15文字以内であれば登録ができること
    it "is invalid with a nickname that has less than 15 characters" do
      user = build(:user, nickname: "aaaaa1234567890")
      user.valid?
      expect(user).to be_valid
    end

    # 13. nicknameが16文字以上であれば登録できないこと
    it "is invalid with a nickname that has more than 15 characters " do
      user = build(:user, nickname: "1234567890123456")
      user.valid?
      expect(user.errors[:nickname]).to include("は15文字以内で入力してください")
    end

    # ----emailに関するテスト----
     # 14. email英数字( ハイフン、ドット、プラス記号を含む)が@マーク前に１文字以上、@終わりのドット前に英小文字、数字、ハイフン、ドットが１文字以上、ドット終わりの後に小英字が１文字以上で登録ができること。
    it "is valid with a email that Contains letters and numbers " do
      user = build(:user, email: "a@a.a")
      user.valid?
      expect(user).to be_valid
    end

    # 15. 重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    # 16. emailの頭に@があると登録できないこと
    it "is invalid with a email includes no character before @ " do
      user = build(:user, email: "@abdd@aaa.com")
      user.valid?
      expect(user.errors[:email][0]).to include("は有効でありません。")
    end

    # 17. emailの最後尾に@があると登録できないこと
    it "is invalid with a email includes no character after @ " do
      user = build(:user, email: "abdd@aaa.com@")
      user.valid?
      expect(user.errors[:email][0]).to include("は有効でありません。")
    end

    # 18. emailの登録で@マーク後の.(ドット）後に英字がない場合は登録ができないこと
    it 'is invalid with a email wrong format' do
      user = build(:user, email: 'a12345678@aaa.111')
      user.valid?
      expect(user.errors[:email]).to include("は有効でありません。")
    end

    # 19. emailの登録で@マーク後の.(ドット）がない場合は登録ができないこと
    it 'is invalid with a email wrong format' do
      user = build(:user, email: 'a12345678@aaacom')
      user.valid?
      expect(user.errors[:email]).to include("は有効でありません。")
    end

    # ----passwordに関するテスト----
    # 20, passwordに英字と数字が含まれており、7から20文字以内でpassword_confirmationと一致していれば登録ができること
    it "is valid with a password that Contains letters and numbers 7 to 20 characters" do
      user = build(:user, password: "a1234567", password_confirmation: "a1234567")
      user.valid?
      expect(user).to be_valid
    end

    # 21. passwordが数字のみ場合は登録ができないこと
    it 'is invalid with a password wrong format' do
      user = build(:user, password: "12345678")
      user.valid?
      expect(user.errors[:password]).to include("は英字と数字両方を含むパスワードを設定してください")
    end

    # 22. passwordが英字のみ場合は登録ができないこと
    it 'is invalid with a password wrong format' do
      user = build(:user, password: "aaaaaaaa")
      user.valid?
      expect(user.errors[:password]).to include("は英字と数字両方を含むパスワードを設定してください")
    end

    # 23. passwordが６文字以下の場合は登録ができないこと
    it "is invalid with a password that has less than 6 characters " do
      user = build(:user, password: "a12345")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください", "は英字と数字両方を含むパスワードを設定してください") 
    end

    # 24. passwordが21文字以上の場合は登録ができないこと
    it "is invalid with a password that has more than 21 characters " do
      user = build(:user, password: "a12345678901234567890")
      user.valid?
      expect(user.errors[:password]).to include("は20文字以内で入力してください", "は英字と数字両方を含むパスワードを設定してください") 
    end

    # 25. passwordに指定した記号を入れても登録ができること
    it "is valid with a password that Contains letters and numbers and symbol " do
      user = build(:user, password: "a1!@#$%^&*)(=_-", password_confirmation: "a1!@#$%^&*)(=_-")
      user.valid?
      expect(user).to be_valid
    end

    # ----first_name,last_nameに関するテスト----
    # 26. first_nameが15文字以内であれば登録ができること
    it "is valid with a first_name that Contains letters and numbers and symbol " do
      user = build(:user, first_name: "aaaaa1234567890")
      user.valid?
      expect(user).to be_valid
    end

    # 27. first_nameが16文字以上であれば登録できないこと
    it "is invalid with a first_name that has more than 15 characters " do
      user = build(:user, first_name: "1234567890123456")
      user.valid?
      expect(user.errors[:first_name]).to include("は15文字以内で入力してください")
    end

    # 28. last_nameが15文字以内であれば登録ができること
    it "is valid with a last_name that has less than 15 characters " do
      user = build(:user, last_name: "aaaaa1234567890")
      user.valid?
      expect(user).to be_valid
    end

    # 29. last_nameが16文字以上であれば登録できないこと
    it "is invalid with a last_name that has more than 15 characters " do
      user = build(:user, last_name: "1234567890123456")
      user.valid?
      expect(user.errors[:last_name]).to include("は15文字以内で入力してください")
    end

    # ----first_name_kana,last_name_kanaに関するテスト----
    # 30. first_name_kanaが20文字以内であれば登録ができること
    it "is invalid with a first_name_kana that has less than 20 characters " do
      user = build(:user, first_name_kana: "アアアアアアアアアアイイイイイイイイイイ")
      user.valid?
      expect(user).to be_valid
    end

    # 31. first_name_kanaに空白、長音記号があっても登録ができること
    it "Valid even if first_name_kana contains spaces and long symbols " do
      user = build(:user, first_name_kana: "ー－　イイイイイイイイイイ")
      user.valid?
      expect(user).to be_valid
    end

    # 32. first_name_kanaがひらがなだと登録ができないこと
    it "is invalid with a first_name_kana that Hiragana " do
      user = build(:user, first_name_kana: "あいうえお")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("はカタカナで入力して下さい。")
    end

    # 33. last_name_kanaが20文字以内であれば登録ができること
    it "is invalid with a last_name_kana that has less than 20 characters " do
      user = build(:user, last_name_kana: "アアアアアアアアアアイイイイイイイイイイ")
      user.valid?
      expect(user).to be_valid
    end

    # 34. last_name_kanaに空白、長音記号があっても登録ができること
    it "Valid even if last_name_kana contains spaces and long symbols " do
      user = build(:user, last_name_kana: "ー－　イイイイイイイイイイ")
      user.valid?
      expect(user).to be_valid
    end

    # 35. last_name_kanaがひらがなだと登録ができないこと
    it "is invalid with a last_name_kana that Hiragana " do
      user = build(:user, last_name_kana: "あいうえお")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("はカタカナで入力して下さい。")
    end

    # ----telephone_numberに関するテスト----
    # 33. 電話番号形式の入力の場合は登録できること
    it "is valid with a telephone_number that Phone number format " do
      user = build(:user, telephone_number: "1234567890")
      user.valid?
      expect(user).to be_valid
    end

    # 34. 電話番号に英字が混ざっていた場合は登録できないこと
    it "is invalid with a telephone_number that Phone number format " do
      user = build(:user, telephone_number: "a123456789")
      user.valid?
      expect(user.errors[:telephone_number]).to include("は有効でありません。")
    end
  end
end