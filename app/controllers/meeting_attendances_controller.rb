class MeetingAttendancesController < ApplicationController
  def index
    authorize attendances

    render :index, locals: { club: club, meeting: meeting, attendances: attendances, new_attendances: new_attendances }
  end

  def update
    meeting.assign_attributes meeting_params

    authorize attendances

    if meeting.save
      redirect_to club_meeting_attendances_url(club, meeting), notice: t(:updated, scope: [:globals], item: Attendance.name)
    else
      render :index, locals: { club: club, meeting: meeting, attendances: attendances, new_attendances: new_attendances }
    end
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

  def meeting_params
    permitted_attributes(meeting)
  end

  def new_attendances
    @new_attendances ||= meeting.non_attendees.map { |member| member.attendances.build(meeting: meeting) }
  end
end
