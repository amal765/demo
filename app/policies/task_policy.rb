class TaskPolicy < ApplicationPolicy

  def create?
    user.admin?
  end

end
