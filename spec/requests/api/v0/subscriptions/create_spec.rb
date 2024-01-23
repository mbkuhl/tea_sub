require 'rails_helper'

describe "Subscriptions Create" do
  it "create vote" do
    test_data
    new_tea = {
      customer_id: @customer2.id,
      tea_id: @t2.id,
      title: "Green Tea Monthly",
      frequency: 30,
      price: 7,
    }


    post "/api/v0/subscriptions", params: new_tea.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to be_successful
    expect(response.status).to eq(201)
  end
end
