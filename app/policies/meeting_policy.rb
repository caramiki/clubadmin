class MeetingPolicy < ApplicationPolicy
  def index?
    record.empty? || user.associated_with?(record.first.club)
  end

  def show?
    user.associated_with? record
  end

  def create?
    show?
  end

  def update?
    show?
  end

  def destroy?
    user.admin_of?(record.club)
  end

  def permitted_attributes
    [
      :title,
      :start_time,
      :end_time,
      :description,
      :notes,
      attendances_attributes: AttendancePolicy.new(user, Attendance).permitted_attributes
    ]
  end
end
