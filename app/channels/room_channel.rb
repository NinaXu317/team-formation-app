class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # stream_for room #room: asabfststgs
    # course = current_user.courses.find_by(params[:course_id]) 
    course = Course.find_by(params[:course_id])
    stream_for course
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
    Rails.logger.info "Disconnected from server" 
  end

end
