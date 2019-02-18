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
end
