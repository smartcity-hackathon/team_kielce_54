# frozen_string_literal: true

module API
  class ProjectsController < BaseController
    def index
      category = Category.find_by(name: params[:category_name])
      projects = paginate_projects(category.projects.active)

      render json: projects, include: ['comments.user', 'user', 'category']
    end

    def archived
      category = Category.find_by(name: params[:category_name])
      projects = paginate_projects(category.projects.archived)

      render json: projects, include: ['comments.user', 'user', 'category']
    end

    def show
      category = Category.find_by(name: params[:category_name])
      project = category.projects.find params[:id]

      render json: project, include: ['comments.user', 'user', 'category']
    end

    private

    def paginate_projects(projects_relation)
      paginate(
        relation: projects_relation.includes(:tags, comments: :user),
        page: params[:page].to_i,
        per_page: params[:per_page].to_i
      )
    end
  end
end
