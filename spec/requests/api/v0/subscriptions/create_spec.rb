require 'rails_helper'

describe "Subscriptions Create" do
  it "create subscription" do
    test_data
    new_tea = {
      customer_id: @customer2.id,
      tea_id: @t2.id,
      title: "Green Tea Monthly",
      frequency: 30,
      price: 7,
    }

    expect(Subscription.all.count).to eq(3)

    post "/api/v0/subscriptions", params: new_tea.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    
    expect(response).to be_successful
    expect(response.status).to eq(201)
    
    expect(Subscription.all.count).to eq(4)

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
    expect(attributes[:status]).to eq("active")
  end

  it "sad path" do
    test_data
    new_tea = {
      customer_id: 1,
      tea_id: @t2.id,
      title: "Green Tea Monthly",
      frequency: 30,
      price: 7,
    }

    expect(Subscription.all.count).to eq(3)

    post "/api/v0/subscriptions", params: new_tea.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)[:errors]

    expect(error.first[:detail]).to eq("Couldn't find Customer with 'id'=1")

  end

  it "sad path 2" do
    test_data
    new_tea = {
      customer_id: @customer1.id,
      tea_id: 1,
      title: "Green Tea Monthly",
      frequency: 30,
      price: 7,
    }

    expect(Subscription.all.count).to eq(3)

    post "/api/v0/subscriptions", params: new_tea.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)[:errors]

    expect(error.first[:detail]).to eq("Couldn't find Tea with 'id'=1")

  end
end
