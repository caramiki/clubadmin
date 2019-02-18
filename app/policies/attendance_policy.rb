class AttendancePolicy < ApplicationPolicy
  def index?
    record.empty? || user.associated_with?(record.first.club)
  end

  def create?
    user.associated_with?(record)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
