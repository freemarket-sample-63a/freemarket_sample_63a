require 'rails_helper'

RSpec.describe Item, type: :model do

  describe '#create' do
    context 'can save' do

      it "is valid item" do
        item = build(:item)
        expect(item).to be_valid
      end

      it 'is valid with title' do
        expect(build(:item, title: "product")).to be_valid
      end

      it 'is valid with description' do
        expect(build(:item, description: "description")).to be_valid
      end

      it 'is valid with address' do
        address = create(:address)
        item = build(:item, address_id: address.id)
        expect(item).to be_valid
      end

      it 'is valid with brand' do
        expect(build(:item, brand_id: nil)).to be_valid
      end

      it 'is valid with category' do
        category = create(:category)
        item = build(:item, category_id: category.id)
        expect(item).to be_valid
      end

      it 'is valid with product_size' do
        expect(build(:item, product_size_id: nil)).to be_valid
      end

      it 'is valid with shippingway' do
        expect(build(:item, shippingway_id: nil)).to be_valid
      end

      it 'is valid with condition_num' do
        expect(build(:item, condition_num: 1)).to be_valid
      end

      it 'is valid with daystoship_num' do
        expect(build(:item, daystoship_num: 1)).to be_valid
      end

      it 'is valid with price' do
        expect(build(:item, price: 1200.000)).to be_valid
      end

      it 'is valid with feerate' do
        expect(build(:item, feerate: 0.100)).to be_valid
      end

      it 'is valid with profit_price' do
        expect(build(:item, profit_price: 900.000)).to be_valid
      end
    end

    context 'can not save' do

      it 'is invalid with title' do
        item = build(:item, title: "")
        item.valid?
        binding.pry
        expect(item.errors[:title])
      end

      it 'is invalid with address' do
        item = build(:item, address_id: "")
        item.valid?
        expect(item.errors[:address_id])
      end
    end

  end
end