class ParticipantsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @meeting = current_user.meetings.find(params[:meeting_id])
    if @meeting.permit(@user)
      Notification.create(notifiable: Participant.find_by(user_id: @user.id, meeting_id: @meeting.id), user: @user)
    end

    @request = Requesting.find_by(user_id: @user.id, meeting_id: @meeting.id)
    @request.destroy!
  end

  def destroy; end
end
