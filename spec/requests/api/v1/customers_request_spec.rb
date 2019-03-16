require "rails_helper"

RSpec.describe "Customers API" do
  describe "Basic Functions" do
    before :each do
      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @customer3 = create(:customer)
    end

    it "returns a single customer" do
      get "/api/v1/customers/#{@customer1.id}"
      expect(response).to be_successful
      customer = JSON.parse(response.body)
      expect(customer["data"]["attributes"]["id"]).to eq(@customer1.id)

      get "/api/v1/customers/#{@customer2.id}"
      expect(response).to be_successful
      customer = JSON.parse(response.body)
      expect(customer["data"]["attributes"]["id"]).to eq(@customer2.id)
    end

    it "returns all customers" do
      binding.pry
      get "/api/v1/customers"
      expect(response).to be_successful
      customers = JSON.parse(response.body)
      expect(customers["data"].count).to eq(3)
      expect(customers["data"][0]["attributes"]["id"]).to eq(@customer1.id)
      expect(customers["data"][1]["attributes"]["id"]).to eq(@customer2.id)
      expect(customers["data"][2]["attributes"]["id"]).to eq(@customer3.id)
    end
  end

  describe "Finders" do
    it "can find a single object based on parameters" do
      @customer1 = create(:customer, created_at: "2019-03-06 21:29:54 UTC", updated_at: "2019-03-08 21:29:54 UTC")
      @customer2 = create(:customer, created_at: "2019-03-02 21:29:54 UTC", updated_at: "2019-03-07 21:29:54 UTC")
      @customer3 = create(:customer)
      @customer4 = create(:customer)

      get "/api/v1/customers/find?id=#{@customer3.id}"
      expect(response).to be_successful
      customer = JSON.parse(response.body)
      expect(customer["data"]["attributes"]["id"]).to eq(@customer3.id)

      get "/api/v1/customers/find?first_name=#{@customer4.first_name}"
      expect(response).to be_successful
      customer = JSON.parse(response.body)
      expect(customer["data"]["attributes"]["id"]).to eq(@customer4.id)

      get "/api/v1/customers/find?last_name=#{@customer4.last_name}"
      expect(response).to be_successful
      customer = JSON.parse(response.body)
      expect(customer["data"]["attributes"]["id"]).to eq(@customer4.id)

      get "/api/v1/customers/find?created_at=#{@customer1.created_at}"
      expect(response).to be_successful
      customer = JSON.parse(response.body)
      expect(customer["data"]["attributes"]["id"]).to eq(@customer1.id)

      get "/api/v1/customers/find?updated_at=#{@customer2.updated_at}"
      expect(response).to be_successful
      customer = JSON.parse(response.body)
      expect(customer["data"]["attributes"]["id"]).to eq(@customer2.id)
    end

    it "can find_all objects based on case-insensitive parameters" do
      @customer1 = create(:customer, created_at: "2019-03-06 21:29:54 UTC", updated_at: "2019-03-08 21:29:54 UTC")
      @customer2 = create(:customer, created_at: "2019-03-02 21:29:54 UTC", updated_at: "2019-03-08 21:29:54 UTC")
      @customer3 = create(:customer, created_at: "2019-03-06 21:29:54 UTC", updated_at: "2019-03-08 21:29:54 UTC")
      @customer4 = create(:customer, first_name: "CustomerFirst", last_name: "CustomerLast")
      @customer5 = create(:customer, first_name: "CustomerFirst", last_name: "CustomerLast")

      get "/api/v1/customers/find_all?id=#{@customer3.id}"
      expect(response).to be_successful
      customer = JSON.parse(response.body)
      expect(customer["data"].count).to eq(1)
      expect(customer["data"][0]["attributes"]["id"]).to eq(@customer3.id)

      get "/api/v1/customers/find_all?first_name=#{@customer4.first_name}"
      expect(response).to be_successful
      customer = JSON.parse(response.body)
      expect(customer["data"].count).to eq(2)
      expect(customer["data"][0]["attributes"]["id"]).to eq(@customer4.id)
      expect(customer["data"][1]["attributes"]["id"]).to eq(@customer5.id)

      get "/api/v1/customers/find_all?last_name=#{@customer4.last_name}"
      expect(response).to be_successful
      customer = JSON.parse(response.body)
      expect(customer["data"].count).to eq(2)
      expect(customer["data"][0]["attributes"]["id"]).to eq(@customer4.id)
      expect(customer["data"][1]["attributes"]["id"]).to eq(@customer5.id)

      get "/api/v1/customers/find_all?created_at=#{@customer1.created_at}"
      expect(response).to be_successful
      customer = JSON.parse(response.body)
      expect(customer["data"].count).to eq(2)
      expect(customer["data"][0]["attributes"]["id"]).to eq(@customer1.id)
      expect(customer["data"][1]["attributes"]["id"]).to eq(@customer3.id)

      get "/api/v1/customers/find_all?updated_at=#{@customer2.updated_at}"
      expect(response).to be_successful
      customer = JSON.parse(response.body)
      expect(customer["data"].count).to eq(3)
      expect(customer["data"][0]["attributes"]["id"]).to eq(@customer1.id)
      expect(customer["data"][1]["attributes"]["id"]).to eq(@customer2.id)
      expect(customer["data"][2]["attributes"]["id"]).to eq(@customer3.id)
    end
  end

  describe "Relationship Endpoints" do
    before :each do
      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @merchant = create(:merchant)
      @invoice1 = create(:invoice, merchant: @merchant, customer: @customer1)
      @invoice2 = create(:invoice, merchant: @merchant, customer: @customer1)
      @invoice3 = create(:invoice, merchant: @merchant, customer: @customer1)
      @invoice4 = create(:invoice, merchant: @merchant, customer: @customer2)
      @invoice5 = create(:invoice, merchant: @merchant, customer: @customer2)
      @invoice6 = create(:invoice, merchant: @merchant, customer: @customer2)
      @invoice7 = create(:invoice, merchant: @merchant, customer: @customer2)
      @transaction1 = create(:transaction, invoice: @invoice1, result: "success")
      @transaction2 = create(:transaction, invoice: @invoice2, result: "success")
      @transaction3 = create(:transaction, invoice: @invoice3, result: nil)
      @transaction4 = create(:transaction, invoice: @invoice3, result: "success")
      @transaction5 = create(:transaction, invoice: @invoice4, result: "success")
      @transaction6 = create(:transaction, invoice: @invoice5, result: "success")
      @transaction7 = create(:transaction, invoice: @invoice6, result: "success")
      @transaction8 = create(:transaction, invoice: @invoice7, result: "success")
    end

    it "returns collection of associated invoices" do
      get "/api/v1/customers/#{@customer1.id}/invoices"
      expect(response).to be_successful
      invoices = JSON.parse(response.body)
      expect(invoices["data"].count).to eq(3)
      expect(invoices["data"][0]["attributes"]["id"]).to eq(@invoice1.id)
      expect(invoices["data"][1]["attributes"]["id"]).to eq(@invoice2.id)
      expect(invoices["data"][2]["attributes"]["id"]).to eq(@invoice3.id)

      get "/api/v1/customers/#{@customer2.id}/invoices"
      expect(response).to be_successful
      invoices = JSON.parse(response.body)
      expect(invoices["data"].count).to eq(4)
      expect(invoices["data"][0]["attributes"]["id"]).to eq(@invoice4.id)
      expect(invoices["data"][1]["attributes"]["id"]).to eq(@invoice5.id)
      expect(invoices["data"][2]["attributes"]["id"]).to eq(@invoice6.id)
      expect(invoices["data"][3]["attributes"]["id"]).to eq(@invoice7.id)
    end

    it "returns collection of associated transactions" do
      get "/api/v1/customers/#{@customer1.id}/transactions"
      expect(response).to be_successful
      transactions = JSON.parse(response.body)
      expect(transactions["data"].count).to eq(4)
      expect(transactions["data"][0]["attributes"]["id"]).to eq(@transaction1.id)
      expect(transactions["data"][1]["attributes"]["id"]).to eq(@transaction2.id)
      expect(transactions["data"][2]["attributes"]["id"]).to eq(@transaction3.id)
      expect(transactions["data"][3]["attributes"]["id"]).to eq(@transaction4.id)

      get "/api/v1/customers/#{@customer2.id}/transactions"
      expect(response).to be_successful
      transactions = JSON.parse(response.body)
      expect(transactions["data"].count).to eq(4)
      expect(transactions["data"][0]["attributes"]["id"]).to eq(@transaction5.id)
      expect(transactions["data"][1]["attributes"]["id"]).to eq(@transaction6.id)
      expect(transactions["data"][2]["attributes"]["id"]).to eq(@transaction7.id)
      expect(transactions["data"][3]["attributes"]["id"]).to eq(@transaction8.id)
    end
  end

  describe "BI Queries" do
    it "finds a customer's favorite merchant" do
      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @merchant3 = create(:merchant)
      @invoice1 = create(:invoice, merchant: @merchant1, customer: @customer1)
      @invoice2 = create(:invoice, merchant: @merchant1, customer: @customer1)
      @invoice3 = create(:invoice, merchant: @merchant2, customer: @customer1)
      @invoice4 = create(:invoice, merchant: @merchant1, customer: @customer2)
      @invoice5 = create(:invoice, merchant: @merchant2, customer: @customer2)
      @invoice6 = create(:invoice, merchant: @merchant3, customer: @customer2)
      @invoice7 = create(:invoice, merchant: @merchant3, customer: @customer2)
      @transaction1 = create(:transaction, invoice: @invoice1, result: "success")
      @transaction2 = create(:transaction, invoice: @invoice2, result: "success")
      @transaction3 = create(:transaction, invoice: @invoice3, result: "failed")
      @transaction4 = create(:transaction, invoice: @invoice3, result: "success")
      @transaction5 = create(:transaction, invoice: @invoice4, result: "success")
      @transaction6 = create(:transaction, invoice: @invoice5, result: "success")
      @transaction7 = create(:transaction, invoice: @invoice6, result: "success")
      @transaction8 = create(:transaction, invoice: @invoice7, result: "success")

      get "/api/v1/customers/#{@customer1.id}/favorite_merchant"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      expect(merchant["data"]["attributes"]["id"]).to eq(@merchant1.id)

      get "/api/v1/customers/#{@customer2.id}/favorite_merchant"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      expect(merchant["data"]["attributes"]["id"]).to eq(@merchant3.id)
    end
  end
end
