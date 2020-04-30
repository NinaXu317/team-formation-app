class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # room = current_user.courses.find_by(params[:course_id]).room
    # stream_for room #room: asabfststgs
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
    Rails.logger.info "Disconnected from server"
  end
end
