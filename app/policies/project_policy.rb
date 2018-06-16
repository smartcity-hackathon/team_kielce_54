# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def create?
    @user.projects.active.count < 3
  end
end
