class MemberPolicy < ApplicationPolicy
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

  # To destroy a member, the user must be an admin of the club, and the member cannot be associated
  # with a user (you must destroy the user's role, not their membership, to remove them from
  # a club)
  def destroy?
    user.admin_of?(record.club) && !record.user
  end
end
