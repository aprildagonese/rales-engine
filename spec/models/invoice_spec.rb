require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "Class Methods" do
    it ".revenue" do
      @merch1, @merch2, @merch3 = create_list(:merchant, 3)
      @item1, @item2, @item3 = create_list(:item, 3, merchant: @merch1)
      @item4, @item5, @item6 = create_list(:item, 3, merchant: @merch2)
      @item7, @item8, @item9 = create_list(:item, 3, merchant: @merch3)
      @customer = create(:customer)
      @invoice1, @invoice2, @invoice3 = create_list(:invoice, 3, customer: @customer, merchant: @merch1, created_at: "2019-03-06 21:29:54 UTC")
      @invoice4, @invoice5, @invoice6 = create_list(:invoice, 3, customer: @customer, merchant: @merch2, created_at: "2019-03-06 21:29:54 UTC")
      @invoice7, @invoice8, @invoice9 = create_list(:invoice, 3, customer: @customer, merchant: @merch3, created_at: "2019-03-08 21:29:54 UTC")
      @inv_item1 = create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 5, unit_price: 5.00, created_at: "2019-03-06 21:29:54 UTC")
      @inv_item2 = create(:invoice_item, invoice: @invoice2, item: @item2, quantity: 4, unit_price: 4.00, created_at: "2019-03-06 21:29:54 UTC")
      @inv_item3 = create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 7, unit_price: 7.00, created_at: "2019-03-06 21:29:54 UTC")
      @inv_item4 = create(:invoice_item, invoice: @invoice4, item: @item4, quantity: 2, unit_price: 2.00, created_at: "2019-03-06 21:29:54 UTC")
      @inv_item5 = create(:invoice_item, invoice: @invoice5, item: @item5, quantity: 9, unit_price: 9.00, created_at: "2019-03-06 21:29:54 UTC")
      @inv_item6 = create(:invoice_item, invoice: @invoice6, item: @item6, quantity: 6, unit_price: 6.00, created_at: "2019-03-06 21:29:54 UTC")
      @inv_item7 = create(:invoice_item, invoice: @invoice7, item: @item7, quantity: 8, unit_price: 8.00, created_at: "2019-03-08 21:29:54 UTC")
      @inv_item8 = create(:invoice_item, invoice: @invoice8, item: @item8, quantity: 1, unit_price: 1.00, created_at: "2019-03-08 21:29:54 UTC")
      @inv_item9 = create(:invoice_item, invoice: @invoice9, item: @item9, quantity: 3, unit_price: 3.00, created_at: "2019-03-08 21:29:54 UTC")
      @transaction1 = create(:transaction, invoice: @invoice1, result: "success")
      @transaction2 = create(:transaction, invoice: @invoice2, result: "success")
      @transaction3 = create(:transaction, invoice: @invoice3, result: "failed")
      @transaction4 = create(:transaction, invoice: @invoice4, result: "success")
      @transaction5 = create(:transaction, invoice: @invoice5, result: "success")
      @transaction6 = create(:transaction, invoice: @invoice6, result: "success")
      @transaction7 = create(:transaction, invoice: @invoice7, result: "success")
      @transaction8 = create(:transaction, invoice: @invoice8, result: "success")
      @transaction9 = create(:transaction, invoice: @invoice9, result: "success")

      expect(Invoice.revenue_by_date(@invoice4.created_at).to_f).to eq(162.0)
      expect(Invoice.revenue_by_date(@invoice7.created_at).to_f).to eq(74.0)
    end
  end
end
