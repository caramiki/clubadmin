class AttendancePolicy < ApplicationPolicy
  def index?
    record.empty? || associated_with_all_attendances?
  end

  def update?
    index?
  end

  def permitted_attributes
    [
      :id,
      :arrival_time,
      :departure_time,
      :notes,
      :meeting_id,
      :member_id,
      :_destroy,
    ]
  end

  private

  def associated_with_all_attendances?
    record.map { |a| user.associated_with? a }.uniq == [true]
  end
end
