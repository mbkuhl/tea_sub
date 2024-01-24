class Api::V0::Customers::SubscriptionsController < ApplicationController

  def index
    customer = Customer.find(params[:id])
    subscriptions = customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions)
  end

end