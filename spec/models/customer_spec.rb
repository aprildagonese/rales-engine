require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Instance Methods" do
    it "#favorite_merchant" do
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
      @transaction3 = create(:transaction, invoice: @invoice3, result: nil)
      @transaction4 = create(:transaction, invoice: @invoice3, result: "success")
      @transaction5 = create(:transaction, invoice: @invoice4, result: "success")
      @transaction6 = create(:transaction, invoice: @invoice5, result: "success")
      @transaction7 = create(:transaction, invoice: @invoice6, result: "success")
      @transaction8 = create(:transaction, invoice: @invoice7, result: "success")

      expect(@customer1.favorite_merchant).to eq(@merchant1)
      expect(@customer2.favorite_merchant).to eq(@merchant3)
    end
  end
end
