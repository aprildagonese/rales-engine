require 'rails_helper'

RSpec.describe "Merchants API" do
  describe "Basic Functions" do
    before :each do
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @merchant3 = create(:merchant)
    end

    it "returns a single merchant" do
      get "/api/v1/merchants/#{@merchant1.id}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      expect(merchant["data"]["attributes"]["id"]).to eq(@merchant1.id)

      get "/api/v1/merchants/#{@merchant2.id}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      expect(merchant["data"]["attributes"]["id"]).to eq(@merchant2.id)
    end

    it "returns all merchants" do
      get "/api/v1/merchants"
      expect(response).to be_successful
      merchants = JSON.parse(response.body)
      expect(merchants["data"].count).to eq(3)
      expect(merchants["data"][0]["attributes"]["id"]).to eq(@merchant1.id)
      expect(merchants["data"][1]["attributes"]["id"]).to eq(@merchant2.id)
      expect(merchants["data"][2]["attributes"]["id"]).to eq(@merchant3.id)
    end
  end

  describe "Finders" do
    it "can find a single object based on parameters" do
      @merchant1 = create(:merchant, created_at: "2019-03-06 21:29:54 UTC", updated_at: "2019-03-08 21:29:54 UTC")
      @merchant2 = create(:merchant, created_at: "2019-03-02 21:29:54 UTC", updated_at: "2019-03-07 21:29:54 UTC")
      @merchant3 = create(:merchant)
      @merchant4 = create(:merchant)

      get "/api/v1/merchants/find?id=#{@merchant3.id}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      expect(merchant["data"]["attributes"]["id"]).to eq(@merchant3.id)

      get "/api/v1/merchants/find?name=#{@merchant4.name}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      expect(merchant["data"]["attributes"]["id"]).to eq(@merchant4.id)

      get "/api/v1/merchants/find?created_at=#{@merchant1.created_at}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      expect(merchant["data"]["attributes"]["id"]).to eq(@merchant1.id)

      get "/api/v1/merchants/find?updated_at=#{@merchant2.updated_at}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      expect(merchant["data"]["attributes"]["id"]).to eq(@merchant2.id)
    end

    it "can find_all objects based on case-insensitive parameters" do
      @merchant1 = create(:merchant, created_at: "2019-03-06 21:29:54 UTC", updated_at: "2019-03-08 21:29:54 UTC")
      @merchant2 = create(:merchant, created_at: "2019-03-02 21:29:54 UTC", updated_at: "2019-03-08 21:29:54 UTC")
      @merchant3 = create(:merchant, created_at: "2019-03-06 21:29:54 UTC", updated_at: "2019-03-08 21:29:54 UTC")
      @merchant4 = create(:merchant, name: "Merchant")
      @merchant5 = create(:merchant, name: "Merchant")

      get "/api/v1/merchants/find_all?id=#{@merchant3.id}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      expect(merchant["data"].count).to eq(1)
      expect(merchant["data"][0]["attributes"]["id"]).to eq(@merchant3.id)

      get "/api/v1/merchants/find_all?name=#{@merchant4.name}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      expect(merchant["data"].count).to eq(2)
      expect(merchant["data"][0]["attributes"]["id"]).to eq(@merchant4.id)
      expect(merchant["data"][1]["attributes"]["id"]).to eq(@merchant5.id)

      get "/api/v1/merchants/find_all?created_at=#{@merchant1.created_at}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      expect(merchant["data"].count).to eq(2)
      expect(merchant["data"][0]["attributes"]["id"]).to eq(@merchant1.id)
      expect(merchant["data"][1]["attributes"]["id"]).to eq(@merchant3.id)

      get "/api/v1/merchants/find_all?updated_at=#{@merchant2.updated_at}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      expect(merchant["data"].count).to eq(3)
      expect(merchant["data"][0]["attributes"]["id"]).to eq(@merchant1.id)
      expect(merchant["data"][1]["attributes"]["id"]).to eq(@merchant2.id)
      expect(merchant["data"][2]["attributes"]["id"]).to eq(@merchant3.id)
    end
  end

  describe "Relationship Endpoints" do
    before :each do
      @customer = create(:customer)
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @item1 = create(:item, merchant: @merchant1)
      @item2 = create(:item, merchant: @merchant1)
      @item3 = create(:item, merchant: @merchant1)
      @item4 = create(:item, merchant: @merchant2)
      @item5 = create(:item, merchant: @merchant2)
      @item6 = create(:item, merchant: @merchant2)
      @item7 = create(:item, merchant: @merchant2)
      @invoice1 = create(:invoice, merchant: @merchant1, customer: @customer)
      @invoice2 = create(:invoice, merchant: @merchant1, customer: @customer)
      @invoice3 = create(:invoice, merchant: @merchant1, customer: @customer)
      @invoice4 = create(:invoice, merchant: @merchant2, customer: @customer)
      @invoice5 = create(:invoice, merchant: @merchant2, customer: @customer)
      @invoice6 = create(:invoice, merchant: @merchant2, customer: @customer)
      @invoice7 = create(:invoice, merchant: @merchant2, customer: @customer)
    end

    it "returns collection of associated items" do
      get "/api/v1/merchants/#{@merchant1.id}/items"
      expect(response).to be_successful
      items = JSON.parse(response.body)
      expect(items["data"].count).to eq(3)
      expect(items["data"][0]["attributes"]["id"]).to eq(@item1.id)
      expect(items["data"][1]["attributes"]["id"]).to eq(@item2.id)
      expect(items["data"][2]["attributes"]["id"]).to eq(@item3.id)

      get "/api/v1/merchants/#{@merchant2.id}/items"
      expect(response).to be_successful
      items = JSON.parse(response.body)
      expect(items["data"].count).to eq(4)
      expect(items["data"][0]["attributes"]["id"]).to eq(@item4.id)
      expect(items["data"][1]["attributes"]["id"]).to eq(@item5.id)
      expect(items["data"][2]["attributes"]["id"]).to eq(@item6.id)
      expect(items["data"][3]["attributes"]["id"]).to eq(@item7.id)
    end

    it "returns collection of associated invoices" do
      get "/api/v1/merchants/#{@merchant1.id}/invoices"
      expect(response).to be_successful
      invoices = JSON.parse(response.body)
      expect(invoices["data"].count).to eq(3)
      expect(invoices["data"][0]["attributes"]["id"]).to eq(@invoice1.id)
      expect(invoices["data"][1]["attributes"]["id"]).to eq(@invoice2.id)
      expect(invoices["data"][2]["attributes"]["id"]).to eq(@invoice3.id)

      get "/api/v1/merchants/#{@merchant2.id}/invoices"
      expect(response).to be_successful
      invoices = JSON.parse(response.body)
      expect(invoices["data"].count).to eq(4)
      expect(invoices["data"][0]["attributes"]["id"]).to eq(@invoice4.id)
      expect(invoices["data"][1]["attributes"]["id"]).to eq(@invoice5.id)
      expect(invoices["data"][2]["attributes"]["id"]).to eq(@invoice6.id)
      expect(invoices["data"][3]["attributes"]["id"]).to eq(@invoice7.id)
    end
  end

  describe "BI Queries" do
    describe "All Merchants" do
      before :each do
        @merch1, @merch2, @merch3 = create_list(:merchant, 3)
        @item1, @item2, @item3 = create_list(:item, 3, merchant: @merch1)
        @item4, @item5, @item6 = create_list(:item, 3, merchant: @merch2)
        @item7, @item8, @item9 = create_list(:item, 3, merchant: @merch3)
        @customer = create(:customer)
        @invoice1, @invoice2, @invoice3 = create_list(:invoice, 3, customer: @customer, merchant: @merch1)
        @invoice4, @invoice5, @invoice6 = create_list(:invoice, 3, customer: @customer, merchant: @merch2)
        @invoice7, @invoice8, @invoice9 = create_list(:invoice, 3, customer: @customer, merchant: @merch3)
        @inv_item1 = create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 5, unit_price: 5.00, created_at: "2019-03-06 21:29:54 UTC")
        @inv_item2 = create(:invoice_item, invoice: @invoice2, item: @item2, quantity: 4, unit_price: 4.00, created_at: "2019-03-06 21:29:54 UTC")
        @inv_item3 = create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 7, unit_price: 7.00, created_at: "2019-03-06 21:29:54 UTC")
        @inv_item4 = create(:invoice_item, invoice: @invoice4, item: @item4, quantity: 2, unit_price: 2.00, created_at: "2019-03-06 21:29:54 UTC")
        @inv_item5 = create(:invoice_item, invoice: @invoice5, item: @item5, quantity: 9, unit_price: 9.00, created_at: "2019-03-07 21:29:54 UTC")
        @inv_item6 = create(:invoice_item, invoice: @invoice6, item: @item6, quantity: 6, unit_price: 6.00, created_at: "2019-03-07 21:29:54 UTC")
        @inv_item7 = create(:invoice_item, invoice: @invoice7, item: @item7, quantity: 8, unit_price: 8.00, created_at: "2019-03-07 21:29:54 UTC")
        @inv_item8 = create(:invoice_item, invoice: @invoice8, item: @item8, quantity: 1, unit_price: 1.00, created_at: "2019-03-07 21:29:54 UTC")
        @inv_item9 = create(:invoice_item, invoice: @invoice9, item: @item9, quantity: 3, unit_price: 3.00, created_at: "2019-03-07 21:29:54 UTC")
        @transaction1 = create(:transaction, invoice: @invoice1, result: "success")
        @transaction2 = create(:transaction, invoice: @invoice2, result: "success")
        @transaction3 = create(:transaction, invoice: @invoice3, result: "failed")
        @transaction4 = create(:transaction, invoice: @invoice4, result: "success")
        @transaction5 = create(:transaction, invoice: @invoice5, result: "success")
        @transaction6 = create(:transaction, invoice: @invoice6, result: "success")
        @transaction7 = create(:transaction, invoice: @invoice7, result: "success")
        @transaction8 = create(:transaction, invoice: @invoice8, result: "success")
        @transaction9 = create(:transaction, invoice: @invoice9, result: "success")
      end

      it "returns X merchants ranked by revenue" do
        get '/api/v1/merchants/most_revenue?quantity=6'
        expect(response).to be_successful
        merchants = JSON.parse(response.body)
        expect(merchants["data"][0]["attributes"]["id"]).to eq(@merch2.id)
        expect(merchants["data"][1]["attributes"]["id"]).to eq(@merch3.id)
        expect(merchants["data"][2]["attributes"]["id"]).to eq(@merch1.id)
      end

      it "returns top X merchants ranked by number sold" do
        get '/api/v1/merchants/most_items?quantity=3'
        expect(response).to be_successful
        merchants = JSON.parse(response.body)
        expect(merchants["data"][0]["attributes"]["id"]).to eq(@merch2.id)
        expect(merchants["data"][1]["attributes"]["id"]).to eq(@merch3.id)
        expect(merchants["data"][2]["attributes"]["id"]).to eq(@merch1.id)
      end

      xit "returns total revenue for date X across all merchants" do
        get "/api/v1/merchants/revenue?date=#{@inv_item1.created_at}"
        revenue = JSON.parse(response.body)
        expect(revenue["data"]["attributes"]["total_revenue"]).to eq("45.00")

        get "/api/v1/merchants/revenue?date=#{@inv_item9.created_at}"
        revenue = JSON.parse(response.body)
        expect(revenue["data"]["attributes"]["total_revenue"]).to eq("191.00")
      end
    end
  end
end
