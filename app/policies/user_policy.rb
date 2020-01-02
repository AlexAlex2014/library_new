# frozen_string_literal: true

# class UserPolicy
class UserPolicy < ApplicationPolicy
  def manage?
    user.master? || record.id == user.id
  end

  def index?
    user.master? || self.user == user
  end

  # class Scope
  class Scope < Scope
    def resolve
      if user.master?
        minor_user = scope.where(master_account: user.id)
        main_user = scope.where(id: user.id)
        minor_user + main_user
      else
        scope.where(id: user.id)
      end
    end
  end
end
