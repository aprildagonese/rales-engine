require 'rails_helper'

describe "Invoices API" do
  xit "sends a list of invoices" do
    create_list(:invoice, 3)

    get '/api/v1/invoices.json'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(3)
  end

  xit "sends a single invoice" do
    create_list(:invoice, 3)
    invoice = Invoice.last

    get "/api/v1/invoices/#{invoice.id}.json"

    expect(response).to be_successful
    invoices = JSON.parse(response.body)
    expect(invoices["id"]).to eq(invoice.id)
  end

  xit "..." do
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

    get '...'
    expect(response).to be_successful
  end

  RSpec.describe "Invoices API" do
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
end
