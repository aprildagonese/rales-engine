require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'class methods' do
    before :each do
      @merch1, @merch2, @merch3 = create_list(:merchant, 3)
      @item1, @item2, @item3 = create_list(:item, 3, merchant: @merch1)
      @item4, @item5, @item6 = create_list(:item, 3, merchant: @merch2)
      @customer = create(:customer)
      @invoice1 = create(:invoice, customer: @customer, merchant: @merch1)
      @invoice2 = create(:invoice, customer: @customer, merchant: @merch2)
      @inv_item1 = create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 1)
      @inv_item2 = create(:invoice_item, invoice: @invoice1, item: @item2, quantity: 4)
      @inv_item3 = create(:invoice_item, invoice: @invoice1, item: @item3, quantity: 3)
      @inv_item4 = create(:invoice_item, invoice: @invoice2, item: @item4, quantity: 5)
      @inv_item5 = create(:invoice_item, invoice: @invoice2, item: @item5, quantity: 2)
    end

    it ".most_items" do
      expected = [@item4, @item2, @item3, @item5]

      expect(Item.most_items(4)).to eq(expected)
    end
  end
end
