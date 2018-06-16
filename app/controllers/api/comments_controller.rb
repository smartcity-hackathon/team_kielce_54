# frozen_string_literal: true

module API
  class CommentsController < BaseController
    before_action :set_project

    def index
      comments = @project.comments

      render json: comments
    end

    def create
      form = CommentsForm.new(comment_params)

      if form.save
        render json: form.comment, status: :created
      else
        render json: form.errors, status: :unprocessable_entity
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:content).tap do |whitelisted|
        whitelisted[:user] = current_user
        whitelisted[:project] = @project
      end
    end

    def set_project
      category = Category.find_by(name: params[:category_name])

      head :not_found unless category

      @project = category.projects.find(params[:project_id])
    end
  end
end
