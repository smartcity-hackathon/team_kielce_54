# frozen_string_literal: true

module API
  class ProjectsController < BaseController
    before_action :set_category

    def index
      projects = paginate_projects(@category.projects.active)

      render json: projects, include: ['comments.user', 'user', 'category']
    end

    def archived
      projects = paginate_projects(@category.projects.archived)

      render json: projects, include: ['comments.user', 'user', 'category']
    end

    def show
      project = @category.projects.find params[:id]

      render json: project, include: ['comments.user', 'user', 'category']
    end

    private

    def set_category
      @category = Category.find_by(name: params[:category_name])

      head :not_found unless @category
    end

    def project_form_params
      params.require(:project).permit!(
        :title, :description, :lat, :lng, :place,
        :budget_type, tags: []
      )
    end

    def paginate_projects(projects_relation)
      paginate(
        relation: projects_relation.includes(:tags, comments: :user),
        page: params[:page].to_i,
        per_page: params[:per_page].to_i
      )
    end
  end
end
