require 'rails_helper'

RSpec.describe "Invoices API" do
  describe "Basic Functions" do
    before :each do
      @customer = create(:customer)
      @merchant = create(:merchant)
      @invoice1, @invoice2, @invoice3 = create_list(:invoice, 3, customer: @customer, merchant: @merchant)
    end

    it "returns a single invoice" do
      get "/api/v1/invoices/#{@invoice1.id}"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"]["attributes"]["id"]).to eq(@invoice1.id)

      get "/api/v1/invoices/#{@invoice2.id}"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"]["attributes"]["id"]).to eq(@invoice2.id)
    end

    it "returns all invoices" do
      get "/api/v1/invoices"
      expect(response).to be_successful
      invoices = JSON.parse(response.body)
      expect(invoices["data"].count).to eq(3)
      expect(invoices["data"][0]["attributes"]["id"]).to eq(@invoice1.id)
      expect(invoices["data"][1]["attributes"]["id"]).to eq(@invoice2.id)
      expect(invoices["data"][2]["attributes"]["id"]).to eq(@invoice3.id)
    end
  end

  describe "Finders" do
    it "can find a single object based on parameters" do
      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @invoice1 = create(:invoice, customer: @customer1, merchant: @merchant2, created_at: "2019-03-06 21:29:54 UTC", updated_at: "2019-03-07 21:29:54 UTC")
      @invoice2 = create(:invoice, customer: @customer2, merchant: @merchant1, status: "shipped", created_at: "2019-03-08 21:29:54 UTC", updated_at: "2019-03-09 21:29:54 UTC")
      @invoice3 = create(:invoice, customer: @customer2, merchant: @merchant2, status: "shipped")


      get "/api/v1/invoices/find?id=#{@invoice3.id}"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"]["attributes"]["id"]).to eq(@invoice3.id)

      get "/api/v1/invoices/find?customer_id=#{@customer2.id}"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"]["attributes"]["id"]).to eq(@invoice2.id)

      get "/api/v1/invoices/find?merchant_id=#{@merchant2.id}"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"]["attributes"]["id"]).to eq(@invoice1.id)

      get "/api/v1/invoices/find?status=shipped"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"]["attributes"]["id"]).to eq(@invoice2.id)

      get "/api/v1/invoices/find?created_at=#{@invoice1.created_at}"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"]["attributes"]["id"]).to eq(@invoice1.id)

      get "/api/v1/invoices/find?updated_at=#{@invoice2.updated_at}"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"]["attributes"]["id"]).to eq(@invoice2.id)
    end

    it "can find_all objects based on case-insensitive parameters" do
      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @invoice1 = create(:invoice, customer: @customer1, merchant: @merchant2, created_at: "2019-03-06 21:29:54 UTC", updated_at: "2019-03-07 21:29:54 UTC")
      @invoice2 = create(:invoice, customer: @customer2, merchant: @merchant1, status: "shipped", created_at: "2019-03-08 21:29:54 UTC", updated_at: "2019-03-09 21:29:54 UTC")
      @invoice3 = create(:invoice, customer: @customer2, merchant: @merchant2, status: "shipped")


      get "/api/v1/invoices/find_all?id=#{@invoice3.id}"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"][0]["attributes"]["id"]).to eq(@invoice3.id)

      get "/api/v1/invoices/find_all?customer_id=#{@customer2.id}"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"][0]["attributes"]["id"]).to eq(@invoice2.id)
      expect(invoice["data"][1]["attributes"]["id"]).to eq(@invoice3.id)

      get "/api/v1/invoices/find_all?merchant_id=#{@merchant2.id}"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"][0]["attributes"]["id"]).to eq(@invoice1.id)
      expect(invoice["data"][1]["attributes"]["id"]).to eq(@invoice3.id)

      get "/api/v1/invoices/find_all?status=shipped"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"][0]["attributes"]["id"]).to eq(@invoice2.id)
      expect(invoice["data"][1]["attributes"]["id"]).to eq(@invoice3.id)

      get "/api/v1/invoices/find_all?created_at=#{@invoice1.created_at}"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"][0]["attributes"]["id"]).to eq(@invoice1.id)

      get "/api/v1/invoices/find_all?updated_at=#{@invoice2.updated_at}"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"][0]["attributes"]["id"]).to eq(@invoice2.id)
    end
  end

  describe "Relationship Endpoints" do
    xit "returns associated invoice" do
      @customer = create(:customer)
      @merchant = create(:merchant)
      @invoice = create(:invoice, customer: @customer, merchant: @merchant)
      @invoice2 = create(:invoice, customer: @customer, merchant: @merchant)
      @transaction1 = create(:transaction, invoice: @invoice, created_at: "2019-03-06 21:29:54 UTC", updated_at: "2019-03-08 21:29:54 UTC")
      @transaction2 = create(:transaction, invoice: @invoice, created_at: "2019-03-02 21:29:54 UTC", updated_at: "2019-03-08 21:29:54 UTC")
      @transaction3 = create(:transaction, invoice: @invoice2, created_at: "2019-03-06 21:29:54 UTC", updated_at: "2019-03-08 21:29:54 UTC")
      @transaction4 = create(:transaction, invoice: @invoice)
      @transaction5 = create(:transaction, invoice: @invoice)

      get "/api/v1/transactions/#{@transaction3.id}/invoice"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"]["attributes"]["id"]).to eq(@invoice2.id)
    end
  end

end
