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
end
