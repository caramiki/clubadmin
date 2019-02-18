class AttendancesController < ApplicationController
  def create
    attendance.assign_attributes attendance_params

    authorize attendance

    if attendance.save
      redirect_to club_attendance_url(club, attendance), notice: t(:created, scope: [:globals], item: Attendance.name)
    else
      render :new, locals: { club: club, attendance: attendance }
    end
  end

  def update
    attendance.assign_attributes attendance_params

    authorize attendance

    if attendance.save
      redirect_to club_attendance_url(club, attendance), notice: t(:updated, scope: [:globals], item: Attendance.name)
    else
      render :edit, locals: { club: club, attendance: attendance }
    end
  end

  def destroy
    authorize attendance

    attendance.destroy

    redirect_to club_attendances_url(club), notice: t(:destroyed, scope: [:globals], item: Attendance.name)
  end

  private

  def attendance
    @attendance ||=
      if params[:id].present?
        Attendance.find_by!(id: params[:id])
      else
        club.attendances.build
      end
  end

  def attendance_params
    params.require(:attendance).permit(:arrival_time, :departure_time, :meeting_id, :member_id)
  end

  def club
    @club ||= Club.find_by!(id: params[:club_id])
  end
end
