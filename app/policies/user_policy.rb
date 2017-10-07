class UserPolicy < ApplicationPolicy

  def show?
    if record[:id] == user.id
      true
    else
      false
    end
  end

  def inviter?
    user.admin?
  end

end
