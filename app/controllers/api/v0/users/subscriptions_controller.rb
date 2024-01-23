class Api::V0::Users::SubscriptionsController < ApplicationController

  def index
    user = User.find(params[:user_id])
    subscriptions = user.subscriptions
    render json: SubscriptionsSerializer.new(subscriptions)
  end

end