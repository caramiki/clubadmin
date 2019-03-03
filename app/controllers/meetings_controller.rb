class MeetingsController < ApplicationController
  def index
    authorize meetings

    render :index, locals: { club: club, meetings: meetings }
  end

  def show
    authorize meeting

    render :show, locals: { club: club, meeting: meeting }
  end

  def new
    authorize meeting

    render :new, locals: { club: club, meeting: meeting }
  end

  def edit
    authorize meeting

    render :edit, locals: { club: club, meeting: meeting }
  end

  def create
    meeting.assign_attributes meeting_params

    authorize meeting

    if meeting.save
      redirect_to club_meeting_url(club, meeting), notice: t(:created, scope: [:globals], item: Meeting.name)
    else
      render :new, locals: { club: club, meeting: meeting }
    end
  end

  def update
    meeting.assign_attributes meeting_params

    authorize meeting

    if meeting.save
      redirect_to club_meeting_url(club, meeting), notice: t(:updated, scope: [:globals], item: Meeting.name)
    else
      render :edit, locals: { club: club, meeting: meeting }
    end
  end

  def destroy
    authorize meeting

    meeting.destroy

    redirect_to club_meetings_url(club), notice: t(:destroyed, scope: [:globals], item: Meeting.name)
  end

  private

  def club
    @club ||= Club.find_by!(id: params[:club_id])
  end

  def meeting
    @meeting ||=
      if params[:id].present?
        Meeting.find_by!(id: params[:id])
      else
        club.meetings.build
      end
  end

  def meetings
    @meetings ||= policy_scope(club.meetings.by_start_time)
  end

  def meeting_params
    params.require(:meeting).permit(:title, :start_time, :end_time, :description, :notes)
  end
end
