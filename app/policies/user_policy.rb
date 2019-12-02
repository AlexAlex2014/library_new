class UserPolicy < ApplicationPolicy
  def manage?
    # raise hghgh
    user.master? || record.id == user.id
    # record.master_account == user
  end

  def index?
    # true
    user.master? || self.user == user
  end

  class Scope < Scope
    def resolve
      # scope.where(id: user.id) || scope.where(master_account: user)
      if user.master?
        minor_user = scope.where(master_account: user.id)
        main_user = scope.where(id: user.id)
        minor_user + main_user
        # scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
end
