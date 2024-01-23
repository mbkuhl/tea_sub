class Api::V0::SubscriptionsController < ApplicationController

  def create
    customer = Customer.find(params[:customer_id])
    tea = Tea.find(params[:tea_id])
    subscription = Subscription.create!(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: 201
  end

  def cancel
    subscription = Subscription.find_by(customer_id: params[:customer_id], tea_id: params[:tea_id])
    subscription.update!(status: 1)
    render json: SubscriptionSerializer.new(subscriptions)
  end

  private

  def subscription_params
    params.permit(:customer_id, :tea_id, :frequency, :price, :title)
  end

end