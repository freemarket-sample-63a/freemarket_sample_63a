require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '#create' do
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
  end
end