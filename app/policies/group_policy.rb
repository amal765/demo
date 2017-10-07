class GroupPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        user.groups
      end
    end
  end

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def show?
    if user.admin? or user.groups.find_by(id: record[:id]).present?
      true
    else
      false
    end
  end




end
