# frozen_string_literal: true

module API
  class CommentsForm
    include ActiveModel::Model

    validates :content, :user, :project, presence: true

    attr_reader :comment
    attr_accessor :content, :user, :project

    def save
      valid? && save_comment
    end

    private

    def save_comment
      @comment = Comment.create(
        user: @user,
        project: @project,
        content: @content
      )
    end
  end
end
