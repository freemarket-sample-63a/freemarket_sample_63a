require 'rails_helper'

RSpec.describe Trade, type: :model do
  describe "#create" do
    let(:trade)    {build_stubbed(:trade) }
    it "is invalid without a item_id" do
      trade.item_id = nil
      expect(trade.errors[:item_id]).to include("を入力してください") if trade.valid?
    end
    it "is invalid without a user_id" do
      trade.user_id = nil
      expect(trade.errors[:user_id]).to include("を入力してください") if trade.valid?
    end
    it "is invalid without a address_id" do
      trade.address_id = nil
      expect(trade.errors[:address_id]).to include("を入力してください") if trade.valid?
    end
    it "is invalid without a status_num" do
      trade.status_num = nil
      expect(trade.errors[:status_num]).to include("を入力してください") if trade.valid?
    end
    it "is invalid duplicate a item_id" do
      trade1 = build_stubbed(:trade)
      address2 = build_stubbed(:buyer_address)
      user2 = build_stubbed(:buyer)
      trade2 = build_stubbed(:trade, item_id: trade1.item_id, user_id: user2.id, address_id: address2.id)
      expect(trade2.errors[:item_id]).to include("はすでに存在します") if trade2.valid?
    end
    it "is valid trade" do
      expect(trade).to be_valid
    end
  end
end