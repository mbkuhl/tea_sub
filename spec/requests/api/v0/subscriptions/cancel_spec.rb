require 'rails_helper'

describe "Subscriptions Cancel" do
  it "cancel subscription" do
    test_data
    new_tea = {
      customer_id: @customer2.id,
      tea_id: @t2.id,
      title: "Green Tea Monthly",
      frequency: 30,
      price: 7,
    }

    post "/api/v0/subscriptions", params: new_tea.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    subscription = Subscription.find_by(customer_id: @customer2.id, tea_id: @t2.id)
    expect(subscription.cancelled?).to be false
    expect(subscription.active?).to be true

    cancel = {
      id: subscription.id
    }
    patch "/api/v0/subscriptions/cancel", params: cancel.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to be_successful
    expect(response.status).to eq(200)

    subscription = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(subscription[:id].to_i).to be_a Integer
    expect(subscription[:id].to_i).to_not eq(0)
    expect(subscription[:type]).to eq("subscription")

    attributes = subscription[:attributes]
    expect(attributes[:tea_id]).to eq(@t2.id)
    expect(attributes[:customer_id]).to eq(@customer2.id)
    expect(attributes[:title]).to eq("Green Tea Monthly")
    expect(attributes[:price]).to eq(7)
    expect(attributes[:frequency]).to eq(30)
    expect(attributes[:status]).to eq("cancelled")

    subscription = Subscription.find_by(customer_id: @customer2.id, tea_id: @t2.id)
    expect(subscription.cancelled?).to be true
    expect(subscription.active?).to be false
  end

  it "sad path" do
    test_data
    cancel = {
      id: 1
    }
    patch "/api/v0/subscriptions/cancel", params: cancel.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }


    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)[:errors]

    expect(error.first[:detail]).to eq("Couldn't find Subscription with 'id'=1")

  end
end

