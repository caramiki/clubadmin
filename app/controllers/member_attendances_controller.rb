class MemberAttendancesController < ApplicationController
  def index
    authorize attendances

    render :index, locals: { club: club, member: member, attendances: attendances }
  end

  private

  def attendances
    @attendances ||= policy_scope(member.attendances.includes(:meeting).by_meeting_start_time_desc)
  end 

  def club
    @club ||= Club.find_by!(id: params[:club_id])
  end

  def member
    @member ||= Member.find_by!(id: params[:member_id])
  end
end
