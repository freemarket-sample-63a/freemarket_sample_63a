require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    it "is valid item" do
      item = build(:item)
      expect(item).to be_valid
    end
  end
end