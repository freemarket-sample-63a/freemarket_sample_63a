require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '#create' do
    let(:address){build_stubbed(:address)}
    #条件を全て満たした場合登録可
    it "is valid address" do
      expect(address).to be_valid
    end

    # ----空の場合に登録が出来ないこと----
    #first_nameが空だと登録できない
    it "is invalid without a first_name" do
      address.first_name = nil
      address.invalid?
    end

    #last_nameが空だと登録できない
    it "is invalid without a last_name" do
      address.last_name = nil
      address.invalid?
    end

    #first_name_kanaが空だと登録できない
    it "is invalid without a first_name_kana" do
      address.first_name_kana = nil
      address.invalid?
    end

    #last_name_kanaが空だと登録できない
    it "is invalid without a last_name_kana" do
      address.last_name_kana = nil
      address.invalid?
    end

    #postal_numberが空だと登録できない
    it "is invalid without a postal_number" do
      address.postal_number = nil
      address.invalid?
    end

    #cityが空だと登録できない
    it "is invalid without a city" do
      address.city = nil
      address.invalid?
    end

    #numberが空だと登録できない
    it "is invalid without a number" do
      address.number = nil
      address.invalid?
    end

    # ----nameに関するテスト----
    #first_name_kanaがひらがなだと登録できない
    it "is invalid with a first_name_kana that Hiragana" do
      address = build(:address, first_name_kana: "あいうえお")
      address.invalid?
    end

    #first_name_kanaが数字だと登録できない-1
    it "is invalid with a first_name_kana that number " do
      address = build(:address, first_name_kana: "12345")
      address.invalid?
    end
    
    #first_name_kanaが数字だと登録できない-2
    it "is invalid with a first_name_kana that sumbol " do
      address = build(:address, first_name_kana: "!#()$%")
      address.invalid?
    end
    
    #first_name_kanaがアルファベットだと登録できない
    it "is invalid with a first_name_kana that Alphabet " do
      address = build(:address, first_name_kana: "abcde")
      address.invalid?
      
    end
    
    #last_name_kanaがひらがなだと登録できない
    it "is invalid with a last_name_kana that Hiragana " do
      address = build(:address, last_name_kana: "あいうえお")
      address.invalid?
    end
    
    #last_name_kanaが数字だと登録できない-1
    it "is invalid with a last_name_kana that number " do
      address = build(:address, last_name_kana: "12345")
      address.invalid?
    end
    
    #last_name_kanaが数字だと登録できない-2
    it "is invalid with a last_name_kana that symbol " do
      address = build(:address, last_name_kana: "!#()$%")
      address.invalid?
    end
    
    #last_name_kanaがアルファベットだと登録できない
    it "is invalid with a last_name_kana that Alphabet " do
      address = build(:address, last_name_kana: "abcde")
      address.invalid?
    end

    # ----postal_numberに関するテスト----
    #postal_numberが8桁以上数字だと登録できない
    it "is invalid with a postal_number that has more than 8 characters" do
      address = build(:address, postal_number: "11111111")
      address.invalid?
    end
    
    #postal_numberが6桁以下数字だと登録できない
    it "is invalid with a postal_number that has less than 6 characters" do
      address = build(:address, postal_number: "111111")
      address.invalid?
    end
    
    #postal_numberにひらがなが入ると登録出来ない
    it "is invalid with a postal_number that hiragana" do
      address = build(:address, postal_number: "あ111111")
      address.invalid?
    end
    
    #postal_numberにカタカナが入ると登録出来ない
    it "is invalid with a postal_number that Katakana" do
      address = build(:address, postal_number: "ア111111")
      address.invalid?
    end

    #postal_numberにアルファベットが入ると登録出来ない
    it "is invalid with a postal_number that Alphabetic" do
      address = build(:address, postal_number: "a111111")
      address.invalid?
    end

    #postal_numberに記号が入ると登録出来ない
    it "is invalid with a postal_number that Symbol" do
      address = build(:address, postal_number: "!111111")
      address.invalid?
    end

  end
end