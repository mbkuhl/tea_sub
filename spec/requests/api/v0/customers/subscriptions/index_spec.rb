require 'rails_helper'

describe "Customer Subscriptions Index" do
  it "customer subscriptions index" do
    test_data
    get "/api/v0/customers/#{@customer1.id}/subscriptions"
    
    expect(response).to be_successful
    expect(response.status).to eq(200)
  end
end