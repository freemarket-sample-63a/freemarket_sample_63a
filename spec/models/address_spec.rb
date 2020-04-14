require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '#create' do
    #条件を全て満たした場合登録可
    it "is valid address" do
      address = build(:address)
      expect(address).to be_valid
    end

    it "is valid address with_ladies_items" do
      address = build(:address, :with_ladies_items)
      expect(address).to be_valid
    end

    it "is valid address with_ladies_trades" do
      address = build(:address, :with_ladies_trades)
      expect(address).to be_valid
    end

    # ----空の場合に登録が出来ないこと----
    #first_nameが空だと登録できない
    it "is invalid without a first_name" do
      address = build(:address, first_name: nil)
      address.valid?
    end

    #last_nameが空だと登録できない
    it "is invalid without a last_name" do
      address.last_name = nil
      expect(address.errors[:last_name]).to include("を入力してください")
    end

    #first_name_kanaが空だと登録できない
    it "is invalid without a first_name_kana" do
      address.first_name_kana = nil
      expect(address.errors[:first_name_kana]).to include("を入力してください")
    end

    #last_name_kanaが空だと登録できない
    it "is invalid without a last_name_kana" do
      address.last_name_kana = nil
      expect(address.errors[:last_name_kana]).to include("を入力してください")
    end

    #postal_numberが空だと登録できない
    it "is invalid without a postal_number" do
      address.postal_number = nil
      expect(address.errors[:postal_number]).to include("を入力してください")
    end

    #cityが空だと登録できない
    it "is invalid without a city" do
      address.city = nil
      expect(address.errors[:city]).to include("を入力してください")
    end

    #numberが空だと登録できない
    it "is invalid without a number" do
      address.number = nil
      expect(address.errors[:number]).to include("を入力してください")
    end

    # ----nameに関するテスト----
    #first_name_kanaがひらがなだと登録できない
    it "is invalid with a first_name_kana that Hiragana" do
      address = build(:address, first_name_kana: "あいうえお")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("はカタカナで入力して下さい。")
    end

    #first_name_kanaが数字だと登録できない-1
    it "is invalid with a first_name_kana that number " do
      address = build(:address, first_name_kana: "12345")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("はカタカナで入力して下さい。")
    end
    
    #first_name_kanaが数字だと登録できない-2
    it "is invalid with a first_name_kana that sumbol " do
      address = build(:address, first_name_kana: "!#()$%")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("はカタカナで入力して下さい。")
    end
    
    #first_name_kanaがアルファベットだと登録できない
    it "is invalid with a first_name_kana that Alphabet " do
      address = build(:address, first_name_kana: "abcde")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("はカタカナで入力して下さい。")
    end
    
    #last_name_kanaがひらがなだと登録できない
    it "is invalid with a last_name_kana that Hiragana " do
      address = build(:address, last_name_kana: "あいうえお")
      address.valid?
      expect(address.errors[:last_name_kana]).to include("はカタカナで入力して下さい。")
    end
    
    #last_name_kanaが数字だと登録できない-1
    it "is invalid with a last_name_kana that number " do
      address = build(:address, last_name_kana: "12345")
      address.valid?
      expect(address.errors[:last_name_kana]).to include("はカタカナで入力して下さい。")
    end
    
    #last_name_kanaが数字だと登録できない-2
    it "is invalid with a last_name_kana that symbol " do
      address = build(:address, last_name_kana: "!#()$%")
      address.valid?
      expect(address.errors[:last_name_kana]).to include("はカタカナで入力して下さい。")
    end
    
    #last_name_kanaがアルファベットだと登録できない
    it "is invalid with a last_name_kana that Alphabet " do
      address = build(:address, last_name_kana: "abcde")
      address.valid?
      expect(address.errors[:last_name_kana]).to include("はカタカナで入力して下さい。")
    end

    # ----postal_numberに関するテスト----
    #postal_numberが8桁以上数字だと登録できない
    it "is invalid with a postal_number that has more than 8 characters" do
      address = build(:address, postal_number: "11111111")
      address.valid?
      expect(address.errors[:postal_number]).to include("は7桁で入力して下さい。")
    end
    
    #postal_numberが6桁以下数字だと登録できない
    it "is invalid with a postal_number that has less than 6 characters" do
      address = build(:address, postal_number: "111111")
      address.valid?
      expect(address.errors[:postal_number]).to include("は7桁で入力して下さい。")
    end
    
    #postal_numberにひらがなが入ると登録出来ない
    it "is invalid with a postal_number that hiragana" do
      address = build(:address, postal_number: "あ111111")
      address.valid?
      expect(address.errors[:postal_number]).to include("は有効ではありません。")
    end
    
    #postal_numberにカタカナが入ると登録出来ない
    it "is invalid with a postal_number that Katakana" do
      address = build(:address, postal_number: "ア111111")
      address.valid?
      expect(address.errors[:postal_number]).to include("は有効ではありません。")
    end

    #postal_numberにアルファベットが入ると登録出来ない
    it "is invalid with a postal_number that Alphabetic" do
      address = build(:address, postal_number: "a111111")
      address.valid?
      expect(address.errors[:postal_number]).to include("は有効ではありません。")
    end

    #postal_numberに記号が入ると登録出来ない
    it "is invalid with a postal_number that Symbol" do
      address = build(:address, postal_number: "!111111")
      address.valid?
      expect(address.errors[:postal_number]).to include("は有効ではありません。")
    end

  end
end