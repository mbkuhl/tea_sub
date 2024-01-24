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
      customer_id: @customer2.id,
      tea_id: @t2.id
    }
    patch "/api/v0/subscriptions/cancel", params: cancel.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to be_successful
    expect(response.status).to eq(200)

    subscription = Subscription.find_by(customer_id: @customer2.id, tea_id: @t2.id)
    expect(subscription.cancelled?).to be true
    expect(subscription.active?).to be false
  end
end

