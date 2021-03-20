class ReadsController < ApplicationController
  before_action :authenticate_user!

  def create
    @notification = Notification.find(params[:notification_id])
    @notification.read! if @notification.unread?
    redirect_back(fallback_location: outputs_url)
  end
end
