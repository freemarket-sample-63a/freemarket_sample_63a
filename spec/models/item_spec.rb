require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    let(:item) {build_stubbed(:item)}
    context 'can save' do
      it "is valid item" do
        expect(item).to be_valid
      end
      #bland_idはnullでも登録できる
      it 'is valid with brand' do
        item.brand_id = nil
        expect(item).to be_valid
      end
      #product_sizeはnullでも登録できる
      it 'is valid with product_size' do
        item.product_size_id = nil
        expect(item).to be_valid
      end
    end

    context 'can not save' do
    #必須事項がnilの場合は登録できない
      it 'is invalid without user_id' do
        item.user_id = nil
        expect(item.errors[:user_id]).to include("を入力してください") if item.valid?
      end

      it "is invalid without title" do
        item.title = nil
        expect(item.errors[:title]).to include("を入力してください") if item.valid?
      end

      it "is invalid without description" do
        item.description = nil
        expect(item.errors[:description]).to include("を入力してください") if item.valid?
      end

      it "is invalid without price" do
        item.price = nil
        expect(item.errors[:price]).to include("を入力してください") if item.valid?
      end

      it 'is invalid without address' do
        item.address_id = nil
        expect(item.errors[:address_id]).to include("を入力してください") if item.valid?
      end

      it 'is invalid without category' do
        item.category = nil
        expect(item.errors[:category]).to include("を入力してください") if item.valid?
      end

      it 'is invalid without condition_num' do
        item.condition_num = nil
        expect(item.errors[:condition_num]).to include("を入力してください") if item.valid?
      end

      it 'is invalid without daystoship_num' do
        item.daystoship_num = nil
        expect(item.errors[:daystoship_num]).to include("を入力してください") if item.valid?
      end

      it 'is invalid without feerate' do
        item.feerate = nil
        expect(item.errors[:feerate]).to include("を入力してください") if item.valid?
      end

      it 'is invalid without profit_price' do
        item.profit_price = nil
        expect(item.errors[:profit_price]).to include("を入力してください") if item.valid?
      end
      #priceが200未満の場合は登録できない
      it 'is invalid price with less than 200' do
        item.price = 199
        expect(item).to be_invalid
      end
      #priceが10,000,000以上の場合は登録できない
      it 'is invalid price with more than 10,000,000' do
        item.price = 10000000
        expect(item).to be_invalid
      end
      #profit_priceが10,000,000以上の場合は登録できない
      it 'is invalid profit_price with more than 10,000,000' do
        item.profit_price = 10000000
        expect(item).to be_invalid
      end
      #feerateが1以上の場合は登録できない
      it 'is invalid feerate more than 1' do
        item.feerate = 1
        expect(item).to be_invalid
      end
      #feerateが0.001未満の場合は登録できない
      it 'is invalid feerate less than 0.0009' do
        item.feerate = 0.0009
        expect(item).to be_invalid
      end
    end
  end
end