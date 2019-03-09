class ClubPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.super_admin?
        scope.all
      else
        user.clubs
      end
    end
  end

  def index?
    signed_in_user?
  end

  def show?
    user.associated_with? record
  end

  def create?
    signed_in_user?
  end

  def update?
    show? && user.admin_of?(record)
  end

  def destroy?
    update?
  end

  def permitted_attributes
    [
      :name,
      :timezone,
      :description,
      :creator_id,
    ]
  end
end
