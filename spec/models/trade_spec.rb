require 'rails_helper'

RSpec.describe Trade, type: :model do
  it "is valid trade" do
    trade = build(:trade)
    expect(trade).to be_valid
  end
  it "is invalid without a status_num" do
    trade = build(:trade, status_num: nil)
    trade.valid?
    expect(trade.errors[:status_num]).to include("を入力してください")
  end
end