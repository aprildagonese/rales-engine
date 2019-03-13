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
      @inv_item1 = create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 1, unit_price: 1.00)
      @inv_item2 = create(:invoice_item, invoice: @invoice1, item: @item2, quantity: 4, unit_price: 4.00)
      @inv_item3 = create(:invoice_item, invoice: @invoice1, item: @item3, quantity: 3, unit_price: 3.00)
      @inv_item4 = create(:invoice_item, invoice: @invoice2, item: @item4, quantity: 5, unit_price: 5.00)
      @inv_item5 = create(:invoice_item, invoice: @invoice2, item: @item5, quantity: 2, unit_price: 2.00)
    end

    it ".most_items" do
      expected = [@item4, @item2, @item3, @item5]

      expect(Item.most_items(4)).to eq(expected)
    end

    it ".most_revenue" do
      expected = [@item4, @item2, @item3, @item5, @item1]
      expect(Item.most_revenue(5)). to eq(expected)
    end
  end

  describe 'instance methods' do
    it '#best_day' do
      @merch1, @merch2, @merch3 = create_list(:merchant, 3)
      @item1, @item2, @item3 = create_list(:item, 3, merchant: @merch1)
      @item4, @item5, @item6 = create_list(:item, 3, merchant: @merch2)
      @customer = create(:customer)
      @item7 = create(:item, merchant: @merch1)
      @item8 = create(:item, merchant: @merch2)
      @invoice3, @invoice4, @invoice5 = create_list(:invoice, 3, merchant: @merch1, customer: @customer)
      @invoice6, @invoice7, @invoice8 = create_list(:invoice, 3, merchant: @merch1, customer: @customer)
      @inv_item6 = create(:invoice_item, invoice: @invoice3, item: @item7, quantity: 5, created_at: "2019-03-06 21:29:54.643366000 +0000")
      @inv_item7 = create(:invoice_item, invoice: @invoice4, item: @item7, quantity: 1, created_at: "2019-03-08 21:29:54.643366000 +0000")
      @inv_item8 = create(:invoice_item, invoice: @invoice5, item: @item7, quantity: 1, created_at: "2019-03-09 21:29:54.643366000 +0000")
      @inv_item9 = create(:invoice_item, invoice: @invoice6, item: @item8, quantity: 1, created_at: "2019-03-07 21:29:54.643366000 +0000")
      @inv_item10 = create(:invoice_item, invoice: @invoice7, item: @item8, quantity: 1, created_at: "2019-03-07 21:29:54.643366000 +0000")
      @inv_item11 = create(:invoice_item, invoice: @invoice8, item: @item8, quantity: 1, created_at: "2019-03-08 21:29:54.643366000 +0000")

      expect(@item7.best_day.first.created_at).to eq("2019-03-06 21:29:54.643366000 +0000")
      expect(@item8.best_day.first.created_at).to eq("2019-03-07 21:29:54.643366000 +0000")
    end
  end
end
