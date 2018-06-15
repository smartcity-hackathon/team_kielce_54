# frozen_string_literal: true

module API
  class ProjectsController < BaseController
    def index
      category = Category.find_by(name: params[:category_name])

      projects = paginate(
        relation: category.projects,
        page: params[:page].to_i,
        per_page: params[:per_page].to_i
      )
      render json: projects
    end
  end
end
