require 'rails_helper'

describe "Merchants API" do
  xit "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end

  xit "sends a single merchant" do
    create_list(:merchant, 3)
    merchant = Merchant.last

    get "/api/v1/merchants/#{merchant.id}.json"

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["id"]).to eq(merchant.id)
  end

  xit "returns top X merchants ranked by number sold" do
    @merch1, @merch2, @merch3 = create_list(:merchant, 3)
    @item1, @item2, @item3 = create_list(:item, 3, merchant: @merch1)
    @item4, @item5, @item6 = create_list(:item, 3, merchant: @merch2)
    @item7, @item8, @item9 = create_list(:item, 3, merchant: @merch3)
    @customer = create(:customer)
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

RSpec.describe "Merchants API" do
  describe "Basic Functions" do
    it "returns a single customer" do
    end

    it "returns all customers" do
    end
  end

  describe "Finders" do
    it "can find a single object based on parameters" do
    end

    it "can find_all objects based on case-insensitive parameters" do
    end
  end

  describe "Relationship Endpoints" do
  end

  describe "BI Queries" do
  end
end
