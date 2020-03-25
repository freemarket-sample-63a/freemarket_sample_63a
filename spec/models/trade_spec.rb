require 'rails_helper'

RSpec.describe Trade, type: :model do
  describe "#create" do
    let(:trade)    { create(:trade) }
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
    it "is invalid duplicate a item_id" do
      trade1 = create(:trade)
      address2 = create(:buyer_address)
      user2 = create(:buyer)
      trade2 = build(:trade, item_id: trade1.item_id, user_id: user2.id, address_id: address2.id)
      trade2.valid?
      expect(trade2.errors[:item_id]).to include("はすでに存在します")
    end
    it "is valid trade" do
      expect(trade).to be_valid
    end
  end
end