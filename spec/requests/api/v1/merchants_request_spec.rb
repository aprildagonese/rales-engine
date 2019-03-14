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
    xit "returns top X merchants ranked by number sold" do
      @merch1, @merch2, @merch3 = create_list(:merchant, 3)
      @item1, @item2, @item3 = create_list(:item, 3, merchant: @merch1)
      @item4, @item5, @item6 = create_list(:item, 3, merchant: @merch2)
      @item7, @item8, @item9 = create_list(:item, 3, merchant: @merch3)
      @merchant = create(:merchant)
      @invoice1 = create(:invoice, customer: @customer, merchant: @merch1)
      @invoice2 = create(:invoice, customer: @customer, merchant: @merch2)
      @invoice3 = create(:invoice, customer: @customer, merchant: @merch3)
      @inv_item1 = create(:invoice_item, invoice: @invoice1, item: @item1)
      @inv_item2 = create(:invoice_item, invoice: @invoice1, item: @item2)
      @inv_item3 = create(:invoice_item, invoice: @invoice1, item: @item3)
      @inv_item4 = create(:invoice_item, invoice: @invoice2, item: @item4)
      @inv_item5 = create(:invoice_item, invoice: @invoice2, item: @item5)
      @inv_item7 = create(:invoice_item, invoice: @invoice3, item: @item7)

      get '/api/v1/merchants/most_items?quantity=x'
      expect(response).to be_successful
    end

    xit "returns X items ranked by revenue" do
      get '/api/v1/merchants/most_revenue?quantity=x'
    end
  end
end
