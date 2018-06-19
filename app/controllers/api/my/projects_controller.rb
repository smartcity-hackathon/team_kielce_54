# frozen_string_literal: true

module API
  module My
    class ProjectsController < BaseController
      def index
        projects = Project.active.where(user_id: current_user.id)

        render json: projects, include: %w[comments user category]
      end
    end
  end
end
