# frozen_string_literal: true

module API
  class CommentSerializer < ActiveModel::Serializer
    belongs_to :user, serializer: UserSerializer

    attributes :content
  end
end
