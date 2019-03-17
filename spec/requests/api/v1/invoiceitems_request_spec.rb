require 'rails_helper'

RSpec.describe "InvoiceItems API" do
  describe "Basic Functions" do
    before :each do
      @customer = create(:customer)
      @merchant = create(:merchant)
      @invoice = create(:invoice, customer: @customer, merchant: @merchant)
      @item1, @item2, @item3 = create_list(:item, 3, merchant: @merchant)
      @invoiceitem1 = create(:invoice_item, invoice: @invoice, item: @item1)
      @invoiceitem2 = create(:invoice_item, invoice: @invoice, item: @item2)
      @invoiceitem3 = create(:invoice_item, invoice: @invoice, item: @item3)
    end

    it "returns a single invoiceitem" do
      get "/api/v1/invoiceitems/#{@invoiceitem1.id}"
      expect(response).to be_successful
      invoiceitem = JSON.parse(response.body)
      expect(invoiceitem["data"]["attributes"]["id"]).to eq(@invoiceitem1.id)

      get "/api/v1/invoiceitems/#{@invoiceitem2.id}"
      expect(response).to be_successful
      invoiceitem = JSON.parse(response.body)
      expect(invoiceitem["data"]["attributes"]["id"]).to eq(@invoiceitem2.id)
    end

    it "returns all invoiceitems" do
      get "/api/v1/invoiceitems"
      expect(response).to be_successful
      invoiceitems = JSON.parse(response.body)
      expect(invoiceitems["data"][0]["attributes"]["id"]).to eq(@invoiceitem1.id)
      expect(invoiceitems["data"][1]["attributes"]["id"]).to eq(@invoiceitem2.id)
      expect(invoiceitems["data"][2]["attributes"]["id"]).to eq(@invoiceitem3.id)
    end
  end

  describe "Finders" do
    it "can find a single object based on parameters" do
      @customer = create(:customer)
      @merchant = create(:merchant)
      @invoice = create(:invoice, customer: @customer, merchant: @merchant)
      @item1, @item2, @item3 = create_list(:item, 3, merchant: @merchant)
      @invoiceitem1 = create(:invoice_item, invoice: @invoice, item: @item1, quantity: 1, unit_price: 1.00, created_at: "2019-03-06 21:29:54 UTC", updated_at: "2019-03-07 21:29:54 UTC")
      @invoiceitem2 = create(:invoice_item, invoice: @invoice, item: @item2, quantity: 2, unit_price: 2.00, created_at: "2019-03-08 21:29:54 UTC", updated_at: "2019-03-09 21:29:54 UTC")
      @invoiceitem3 = create(:invoice_item, invoice: @invoice, item: @item3, quantity: 3, unit_price: 3.00, created_at: "2019-03-10 21:29:54 UTC", updated_at: "2019-03-11 21:29:54 UTC")


      get "/api/v1/invoiceitems/find?id=#{@invoiceitem3.id}"
      expect(response).to be_successful
      invoiceitem = JSON.parse(response.body)
      expect(invoiceitem["data"]["attributes"]["id"]).to eq(@invoiceitem3.id)

      get "/api/v1/invoiceitems/find?item_id=#{@item2.id}"
      expect(response).to be_successful
      invoiceitem = JSON.parse(response.body)
      expect(invoiceitem["data"]["attributes"]["id"]).to eq(@invoiceitem2.id)

      get "/api/v1/invoiceitems/find?invoice_id=#{@invoice.id}"
      expect(response).to be_successful
      invoiceitem = JSON.parse(response.body)
      expect(invoiceitem["data"]["attributes"]["id"]).to eq(@invoiceitem1.id)

      get "/api/v1/invoiceitems/find?quantity=#{@invoiceitem3.quantity}"
      expect(response).to be_successful
      invoiceitem = JSON.parse(response.body)
      expect(invoiceitem["data"]["attributes"]["id"]).to eq(@invoiceitem3.id)

      get "/api/v1/invoiceitems/find?unit_price=#{@invoiceitem2.unit_price}"
      expect(response).to be_successful
      invoiceitem = JSON.parse(response.body)
      expect(invoiceitem["data"]["attributes"]["id"]).to eq(@invoiceitem2.id)

      get "/api/v1/invoiceitems/find?created_at=#{@invoiceitem1.created_at}"
      expect(response).to be_successful
      invoiceitem = JSON.parse(response.body)
      expect(invoiceitem["data"]["attributes"]["id"]).to eq(@invoiceitem1.id)

      get "/api/v1/invoiceitems/find?updated_at=#{@invoiceitem2.updated_at}"
      expect(response).to be_successful
      invoiceitem = JSON.parse(response.body)
      expect(invoiceitem["data"]["attributes"]["id"]).to eq(@invoiceitem2.id)
    end

    it "can find_all objects based on case-insensitive parameters" do
      @customer = create(:customer)
      @merchant = create(:merchant)
      @invoice = create(:invoice, customer: @customer, merchant: @merchant)
      @item1, @item2, @item3 = create_list(:item, 3, merchant: @merchant)
      @invoiceitem1 = create(:invoice_item, invoice: @invoice, item: @item1, quantity: 1, unit_price: 1.00, created_at: "2019-03-08 21:29:54 UTC", updated_at: "2019-03-07 21:29:54 UTC")
      @invoiceitem2 = create(:invoice_item, invoice: @invoice, item: @item2, quantity: 1, unit_price: 3.00, created_at: "2019-03-08 21:29:54 UTC", updated_at: "2019-03-11 21:29:54 UTC")
      @invoiceitem3 = create(:invoice_item, invoice: @invoice, item: @item2, quantity: 3, unit_price: 3.00, created_at: "2019-03-10 21:29:54 UTC", updated_at: "2019-03-11 21:29:54 UTC")

      get "/api/v1/invoiceitems/find_all?id=#{@invoiceitem3.id}"
      expect(response).to be_successful
      invoiceitems = JSON.parse(response.body)
      expect(invoiceitems["data"][0]["attributes"]["id"]).to eq(@invoiceitem3.id)

      get "/api/v1/invoiceitems/find_all?item_id=#{@item2.id}"
      expect(response).to be_successful
      invoiceitems = JSON.parse(response.body)
      expect(invoiceitems["data"][0]["attributes"]["id"]).to eq(@invoiceitem2.id)
      expect(invoiceitems["data"][1]["attributes"]["id"]).to eq(@invoiceitem3.id)

      get "/api/v1/invoiceitems/find_all?invoice_id=#{@invoice.id}"
      expect(response).to be_successful
      invoiceitems = JSON.parse(response.body)
      expect(invoiceitems["data"][0]["attributes"]["id"]).to eq(@invoiceitem1.id)
      expect(invoiceitems["data"][1]["attributes"]["id"]).to eq(@invoiceitem2.id)
      expect(invoiceitems["data"][2]["attributes"]["id"]).to eq(@invoiceitem3.id)

      get "/api/v1/invoiceitems/find_all?quantity=#{@invoiceitem1.quantity}"
      expect(response).to be_successful
      invoiceitems = JSON.parse(response.body)
      expect(invoiceitems["data"][0]["attributes"]["id"]).to eq(@invoiceitem1.id)
      expect(invoiceitems["data"][1]["attributes"]["id"]).to eq(@invoiceitem2.id)

      get "/api/v1/invoiceitems/find_all?unit_price=#{@invoiceitem2.unit_price}"
      expect(response).to be_successful
      invoiceitems = JSON.parse(response.body)
      expect(invoiceitems["data"][0]["attributes"]["id"]).to eq(@invoiceitem2.id)
      expect(invoiceitems["data"][1]["attributes"]["id"]).to eq(@invoiceitem3.id)

      get "/api/v1/invoiceitems/find_all?created_at=#{@invoiceitem1.created_at}"
      expect(response).to be_successful
      invoiceitems = JSON.parse(response.body)
      expect(invoiceitems["data"][0]["attributes"]["id"]).to eq(@invoiceitem1.id)
      expect(invoiceitems["data"][1]["attributes"]["id"]).to eq(@invoiceitem2.id)

      get "/api/v1/invoiceitems/find_all?updated_at=#{@invoiceitem2.updated_at}"
      expect(response).to be_successful
      invoiceitems = JSON.parse(response.body)
      expect(invoiceitems["data"][0]["attributes"]["id"]).to eq(@invoiceitem2.id)
      expect(invoiceitems["data"][1]["attributes"]["id"]).to eq(@invoiceitem3.id)
    end
  end

  describe "Relationship Endpoints" do
    before :each do
      @customer = create(:customer)
      @merchant = create(:merchant)
      @invoice = create(:invoice, customer: @customer, merchant: @merchant)
      @item1, @item2, @item3 = create_list(:item, 3, merchant: @merchant)
      @invoiceitem1 = create(:invoice_item, invoice: @invoice, item: @item1, quantity: 1, unit_price: 1.00, created_at: "2019-03-08 21:29:54 UTC", updated_at: "2019-03-07 21:29:54 UTC")
      @invoiceitem2 = create(:invoice_item, invoice: @invoice, item: @item2, quantity: 1, unit_price: 3.00, created_at: "2019-03-08 21:29:54 UTC", updated_at: "2019-03-11 21:29:54 UTC")
      @invoiceitem3 = create(:invoice_item, invoice: @invoice, item: @item2, quantity: 3, unit_price: 3.00, created_at: "2019-03-10 21:29:54 UTC", updated_at: "2019-03-11 21:29:54 UTC")
    end

    it "returns associated invoice" do
      get "/api/v1/invoiceitems/#{@invoiceitem1.id}/invoice"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      expect(invoice["data"]["attributes"]["id"]).to eq(@invoice.id)
    end

    it "returns associated invoice" do
      get "/api/v1/invoiceitems/#{@invoiceitem2.id}/item"
      expect(response).to be_successful
      item = JSON.parse(response.body)
      expect(item["data"]["attributes"]["id"]).to eq(@item2.id)
    end
  end

end
