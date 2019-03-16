require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merch1, @merch2, @merch3 = create_list(:merchant, 3)
    @item1, @item2, @item3 = create_list(:item, 3, merchant: @merch1)
    @item4, @item5, @item6 = create_list(:item, 3, merchant: @merch1)
    @item7, @item8, @item9, @item10 = create_list(:item, 4, merchant: @merch2)
    @item11, @item12, @item13 = create_list(:item, 3, merchant: @merch3)
    @customer1, @customer2, @customer3 = create_list(:customer, 3)
    @invoice1, @invoice2, @invoice3 = create_list(:invoice, 3, customer: @customer2, merchant: @merch1, created_at: "2019-03-06 21:29:54 UTC")
    @invoice4, @invoice5 = create_list(:invoice, 2, customer: @customer2, merchant: @merch1, created_at: "2019-03-07 21:29:54 UTC")
    @invoice6 = create(:invoice, customer: @customer2, merchant: @merch1, created_at: "2019-03-08 21:29:54 UTC")
    @invoice7, @invoice8 = create_list(:invoice, 2, customer: @customer2, merchant: @merch2, created_at: "2019-03-08 21:29:54 UTC")
    @invoice9 = create(:invoice, customer: @customer3, merchant: @merch2, created_at: "2019-03-09 21:29:54 UTC")
    @invoice10 = create(:invoice, customer: @customer3, merchant: @merch2, created_at: "2019-03-10 21:29:54 UTC")
    @invoice13 = create(:invoice, customer: @customer2, merchant: @merch3, created_at: "2019-03-09 21:29:54 UTC")
    @invoice11, @invoice12 = create_list(:invoice, 2, customer: @customer1, merchant: @merch3, created_at: "2019-03-08 21:29:54 UTC")
    @invoice14 = create(:invoice, customer: @customer1, merchant: @merch1, created_at: "2019-03-09 21:29:54 UTC")
    @invoice15 = create(:invoice, customer: @customer3, merchant: @merch2, created_at: "2019-03-09 21:29:54 UTC")
    @inv_item1 = create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 5, unit_price: 5.00, created_at: "2019-03-06 21:29:54 UTC")
    @inv_item2 = create(:invoice_item, invoice: @invoice2, item: @item2, quantity: 4, unit_price: 4.00, created_at: "2019-03-06 21:29:54 UTC")
    @inv_item3 = create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 7, unit_price: 7.00, created_at: "2019-03-06 21:29:54 UTC")
    @inv_item4 = create(:invoice_item, invoice: @invoice4, item: @item4, quantity: 2, unit_price: 2.00, created_at: "2019-03-07 21:29:54 UTC")
    @inv_item5 = create(:invoice_item, invoice: @invoice5, item: @item5, quantity: 9, unit_price: 9.00, created_at: "2019-03-07 21:29:54 UTC")
    @inv_item6 = create(:invoice_item, invoice: @invoice6, item: @item6, quantity: 6, unit_price: 6.00, created_at: "2019-03-08 21:29:54 UTC")
    @inv_item7 = create(:invoice_item, invoice: @invoice7, item: @item7, quantity: 8, unit_price: 8.00, created_at: "2019-03-08 21:29:54 UTC")
    @inv_item8 = create(:invoice_item, invoice: @invoice8, item: @item8, quantity: 5, unit_price: 1.00, created_at: "2019-03-08 21:29:54 UTC")
    @inv_item9 = create(:invoice_item, invoice: @invoice9, item: @item9, quantity: 5, unit_price: 1.00, created_at: "2019-03-09 21:29:54 UTC")
    @inv_item10 = create(:invoice_item, invoice: @invoice10, item: @item10, quantity: 5, unit_price: 1.00, created_at: "2019-03-10 21:29:54 UTC")
    @inv_item11 = create(:invoice_item, invoice: @invoice11, item: @item11, quantity: 1, unit_price: 10.00, created_at: "2019-03-08 21:29:54 UTC")
    @inv_item12 = create(:invoice_item, invoice: @invoice12, item: @item12, quantity: 1, unit_price: 10.00, created_at: "2019-03-08 21:29:54 UTC")
    @inv_item13 = create(:invoice_item, invoice: @invoice13, item: @item12, quantity: 1, unit_price: 10.00, created_at: "2019-03-09 21:29:54 UTC")
    @inv_item14 = create(:invoice_item, invoice: @invoice14, item: @item1, quantity: 0, unit_price: 10.00, created_at: "2019-03-09 21:29:54 UTC")
    @inv_item15 = create(:invoice_item, invoice: @invoice15, item: @item8, quantity: 0, unit_price: 10.00, created_at: "2019-03-09 21:29:54 UTC")
    @transaction1 = create(:transaction, invoice: @invoice1, result: "success")
    @transaction2 = create(:transaction, invoice: @invoice2, result: "success")
    @transaction3 = create(:transaction, invoice: @invoice3, result: "failed")
    @transaction4 = create(:transaction, invoice: @invoice4, result: "success")
    @transaction5 = create(:transaction, invoice: @invoice5, result: "success")
    @transaction6 = create(:transaction, invoice: @invoice6, result: "success")
    @transaction7 = create(:transaction, invoice: @invoice7, result: "failed")
    @transaction8 = create(:transaction, invoice: @invoice8, result: "success")
    @transaction9 = create(:transaction, invoice: @invoice9, result: "success")
    @transaction10 = create(:transaction, invoice: @invoice10, result: "success")
    @transaction11 = create(:transaction, invoice: @invoice11, result: "success")
    @transaction12 = create(:transaction, invoice: @invoice12, result: "success")
    @transaction13 = create(:transaction, invoice: @invoice13, result: "success")
    @transaction14 = create(:transaction, invoice: @invoice14, result: "failed")
    @transaction15 = create(:transaction, invoice: @invoice15, result: "failed")
  end

  describe "Class Methods" do
    it ".most_revenue" do
      merchants = [@merch1, @merch3, @merch2]
      expect(Merchant.most_revenue).to eq(merchants)
    end

    it ".most_items" do
      merchants = [@merch1, @merch2, @merch3]
      expect(Merchant.most_items).to eq(merchants)
    end
  end

  describe "Instance Methods" do
    it "#revenue" do
      expect(@merch1.revenue.to_f).to eq(162.0)
      expect(@merch2.revenue.to_f).to eq(15.0)
      expect(@merch3.revenue.to_f).to eq(30.0)
    end

    it "#revenue_by_date" do
      expect(@merch1.revenue_by_date(@invoice1.created_at).to_f).to eq(41.0)
      expect(@merch1.revenue_by_date(@invoice4.created_at).to_f).to eq(85.0)
      expect(@merch2.revenue_by_date(@invoice7.created_at).to_f).to eq(5.0)
      expect(@merch3.revenue_by_date(@invoice12.created_at).to_f).to eq(20.0)
    end

    it "#favorite_customer" do
      expect(@merch1.favorite_customer).to eq(@customer2)
      expect(@merch2.favorite_customer).to eq(@customer3)
      expect(@merch3.favorite_customer).to eq(@customer1)
    end

    it "#customers_with_pending_invoices" do
      expect(@merch1.customers_with_pending_invoices).to eq([@customer1, @customer2])
      expect(@merch2.customers_with_pending_invoices).to eq([@customer2, @customer3])
      expect(@merch3.customers_with_pending_invoices).to eq([])
    end
  end
end
