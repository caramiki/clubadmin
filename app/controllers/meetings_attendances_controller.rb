class MeetingsAttendancesController < ApplicationController
  def index
    authorize attendances

    render :index, locals: { club: club, meeting: meeting, attendances: attendances }
  end

  private

  def attendances
    @attendances ||= policy_scope(meeting.attendances.includes(:attendee))
  end

  def club
    @club ||= Club.find_by!(id: params[:club_id])
  end

  def meeting
    @meeting ||= Meeting.find_by!(id: params[:meeting_id])
  end
end
