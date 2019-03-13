require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items.json'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end

  it "sends a single item" do
    create_list(:item, 3)
    item = Item.last

    get "/api/v1/items/#{item.id}.json"

    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items["id"]).to eq(item.id)
    # expect(items.count).to eq(1)
  end

  it "returns X items ranked by number sold" do
    @merch1, @merch2, @merch3 = create_list(:merchant, 3)
    @item1, @item2, @item3 = create_list(:item, 3, merchant: @merch1)
    @item4, @item5, @item6 = create_list(:item, 3, merchant: @merch2)
    @customer = create(:customer)
    @invoice1 = create(:invoice, customer: @customer, merchant: @merch1)
    @invoice2 = create(:invoice, customer: @customer, merchant: @merch2)
    @inv_item1 = create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 1)
    @inv_item2 = create(:invoice_item, invoice: @invoice1, item: @item2, quantity: 4)
    @inv_item3 = create(:invoice_item, invoice: @invoice1, item: @item3, quantity: 3)
    @inv_item4 = create(:invoice_item, invoice: @invoice2, item: @item4, quantity: 5)
    @inv_item5 = create(:invoice_item, invoice: @invoice2, item: @item5, quantity: 2)

    get '/api/v1/items/most_items?quantity=1'
    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item[:id]).to eq(@item4.id)
  end

  xit "returns X items ranked by revenue" do
    get '/api/v1/items/most_revenue?quantity=x'
  end
end
