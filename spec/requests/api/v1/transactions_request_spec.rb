require 'rails_helper'

RSpec.describe "Transactions API" do
  describe "Basic Functions" do
    before :each do
      @customer = create(:customer)
      @merchant = create(:merchant)
      @invoice = create(:invoice, customer: @customer, merchant: @merchant)
      @transaction1 = create(:transaction, invoice: @invoice)
      @transaction2 = create(:transaction, invoice: @invoice)
      @transaction3 = create(:transaction, invoice: @invoice)
    end

    it "returns a single transaction" do
      get "/api/v1/transactions/#{@transaction1.id}"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      expect(transaction["data"]["attributes"]["id"]).to eq(@transaction1.id)

      get "/api/v1/transactions/#{@transaction2.id}"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      expect(transaction["data"]["attributes"]["id"]).to eq(@transaction2.id)
    end

    it "returns all transactions" do
      get "/api/v1/transactions"
      expect(response).to be_successful
      transactions = JSON.parse(response.body)
      expect(transactions["data"].count).to eq(3)
      expect(transactions["data"][0]["attributes"]["id"]).to eq(@transaction1.id)
      expect(transactions["data"][1]["attributes"]["id"]).to eq(@transaction2.id)
      expect(transactions["data"][2]["attributes"]["id"]).to eq(@transaction3.id)
    end
  end

  describe "Finders" do
    it "can find a single object based on parameters" do
      @customer = create(:customer)
      @merchant = create(:merchant)
      @invoice = create(:invoice, customer: @customer, merchant: @merchant)
      @invoice2 = create(:invoice, customer: @customer, merchant: @merchant)
      @transaction1 = create(:transaction, invoice: @invoice, created_at: "2019-03-06 21:29:54 UTC", updated_at: "2019-03-08 21:29:54 UTC")
      @transaction2 = create(:transaction, invoice: @invoice, created_at: "2019-03-02 21:29:54 UTC", updated_at: "2019-03-07 21:29:54 UTC")
      @transaction3 = create(:transaction, invoice: @invoice, credit_card_number: "123456")
      @transaction4 = create(:transaction, invoice: @invoice, result: "failed")
      @transaction5 = create(:transaction, invoice: @invoice2)

      get "/api/v1/transactions/find?id=#{@transaction3.id}"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      expect(transaction["data"]["attributes"]["id"]).to eq(@transaction3.id)

      get "/api/v1/transactions/find?invoice_id=#{@invoice2.id}"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      expect(transaction["data"]["attributes"]["id"]).to eq(@transaction5.id)

      get "/api/v1/transactions/find?credit_card_number=#{@transaction3.credit_card_number}"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      expect(transaction["data"]["attributes"]["id"]).to eq(@transaction3.id)

      get "/api/v1/transactions/find?result=#{@transaction4.result}"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      expect(transaction["data"]["attributes"]["id"]).to eq(@transaction4.id)

      get "/api/v1/transactions/find?created_at=#{@transaction1.created_at}"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      expect(transaction["data"]["attributes"]["id"]).to eq(@transaction1.id)

      get "/api/v1/transactions/find?updated_at=#{@transaction2.updated_at}"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      expect(transaction["data"]["attributes"]["id"]).to eq(@transaction2.id)
    end

    it "can find_all objects based on case-insensitive parameters" do
      @customer = create(:customer)
      @merchant = create(:merchant)
      @invoice = create(:invoice, customer: @customer, merchant: @merchant)
      @invoice2 = create(:invoice, customer: @customer, merchant: @merchant)
      @transaction1 = create(:transaction, invoice: @invoice, result: "failed", created_at: "2019-03-06 21:29:54 UTC", updated_at: "2019-03-08 21:29:54 UTC")
      @transaction2 = create(:transaction, invoice: @invoice, created_at: "2019-03-02 21:29:54 UTC", updated_at: "2019-03-07 21:29:54 UTC")
      @transaction3 = create(:transaction, invoice: @invoice, credit_card_number: "123456", created_at: "2019-03-11 21:29:54 UTC", updated_at: "2019-03-15 21:29:54 UTC")
      @transaction4 = create(:transaction, invoice: @invoice2, result: "failed", created_at: "2019-03-11 21:29:54 UTC", updated_at: "2019-03-17 21:29:54 UTC")
      @transaction5 = create(:transaction, invoice: @invoice2, credit_card_number: "123456", created_at: "2019-03-11 21:29:54 UTC", updated_at: "2019-03-17 21:29:54 UTC")

      get "/api/v1/transactions/find_all?id=#{@transaction3.id}"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      expect(transaction["data"].count).to eq(1)
      expect(transaction["data"][0]["attributes"]["id"]).to eq(@transaction3.id)

      get "/api/v1/transactions/find_all?invoice_id=#{@invoice2.id}"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      expect(transaction["data"][0]["attributes"]["id"]).to eq(@transaction4.id)
      expect(transaction["data"][1]["attributes"]["id"]).to eq(@transaction5.id)

      get "/api/v1/transactions/find_all?credit_card_number=#{@transaction3.credit_card_number}"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      expect(transaction["data"].count).to eq(2)
      expect(transaction["data"][0]["attributes"]["id"]).to eq(@transaction3.id)
      expect(transaction["data"][1]["attributes"]["id"]).to eq(@transaction5.id)

      get "/api/v1/transactions/find_all?result=failed"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      expect(transaction["data"][0]["attributes"]["id"]).to eq(@transaction1.id)
      expect(transaction["data"][1]["attributes"]["id"]).to eq(@transaction4.id)

      get "/api/v1/transactions/find_all?created_at=#{@transaction3.created_at}"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      expect(transaction["data"][0]["attributes"]["id"]).to eq(@transaction3.id)
      expect(transaction["data"][1]["attributes"]["id"]).to eq(@transaction4.id)
      expect(transaction["data"][2]["attributes"]["id"]).to eq(@transaction5.id)

      get "/api/v1/transactions/find_all?updated_at=#{@transaction4.updated_at}"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      expect(transaction["data"][0]["attributes"]["id"]).to eq(@transaction4.id)
      expect(transaction["data"][1]["attributes"]["id"]).to eq(@transaction5.id)
    end
  end

  describe "Relationship Endpoints" do
    it "returns associated invoice" do
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
