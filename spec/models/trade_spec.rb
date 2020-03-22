require 'rails_helper'

RSpec.describe Trade, type: :model do
  describe "#create" do
    let(:seller) { create(:user) }
    let(:item) { create(:item, user_id: seller.id) }
    let(:buyer) { create(:user) }
    let(:address) { create(:address, user_id: buyer.id) }

    it "is invalid without a item_id" do
      trade = build(:trade, item_id: nil)
      trade.valid?
      expect(trade.errors[:item_id]).to include("を入力してください")
    end
    it "is invalid without a user_id" do
      trade = build(:trade, user_id: nil)
      trade.valid?
      expect(trade.errors[:user_id]).to include("を入力してください")
    end
    it "is invalid without a address_id" do
      trade = build(:trade, address_id: nil)
      trade.valid?
      expect(trade.errors[:address_id]).to include("を入力してください")
    end
    it "is invalid without a status_num" do
      trade = build(:trade, status_num: nil)
      trade.valid?
      expect(trade.errors[:status_num]).to include("を入力してください")
    end
    it "is valid trade" do
      seller
      binding.pry
      item
      buyer
      address
      binding.pry
      trade = build(:trade, item_id: item.id, user_id: buyre.id, address_id: address.id)
      trade.valid?
      binding.pry
      expect(trade).to be_valid
    end
  end
end