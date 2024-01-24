require 'rails_helper'

describe "Customer Subscriptions Index" do
  it "customer subscriptions index" do
    test_data
    get "/api/v0/customers/#{@customer1.id}/subscriptions"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    subscription = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(subscription).to be_a Array
    expect(subscription.first[:id].to_i).to be_a Integer
    expect(subscription.first[:id].to_i).to_not eq(0)
    expect(subscription.first[:type]).to eq("subscription")

    attributes = subscription.first[:attributes]
    expect(attributes[:tea_id]).to eq(@t1.id)
    expect(attributes[:customer_id]).to eq(@customer1.id)
    expect(attributes[:title]).to eq("Hygge Sub")
    expect(attributes[:price]).to eq(10)
    expect(attributes[:frequency]).to eq(30)
    expect(attributes[:status]).to eq("active")

    expect(subscription[1][:id].to_i).to be_a Integer
    expect(subscription[1][:id].to_i).to_not eq(0)
    expect(subscription[1][:type]).to eq("subscription")

    attributes = subscription[1][:attributes]
    expect(attributes[:tea_id]).to eq(@t2.id)
    expect(attributes[:customer_id]).to eq(@customer1.id)
    expect(attributes[:title]).to eq("Green Tea Sub")
    expect(attributes[:price]).to eq(12)
    expect(attributes[:frequency]).to eq(60)
    expect(attributes[:status]).to eq("cancelled")
  end

  it "sad path" do
    test_data
    get "/api/v0/customers/1/subscriptions"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)[:errors]

    expect(error.first[:detail]).to eq("Couldn't find Customer with 'id'=1")
  end
end