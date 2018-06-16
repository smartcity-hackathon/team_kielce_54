# frozen_string_literal: true

module API
  class ProjectSerializer < ActiveModel::Serializer
    has_many :comments, serializer: CommentSerializer
    belongs_to :category, serializer: CategorySerializer
    belongs_to :user, serializer: UserSerializer

    attributes :title, :description, :lat, :lng, :place,
               :status, :votes_count, :tags

    def tags
      tags_to_serialize = object.tags
      tags_to_serialize += Array.wrap(budget_tag) if object.budget_type.present?

      ActiveModel::SerializableResource.new(
        tags_to_serialize,
        each_serializer: TagSerializer
      ).as_json
    end

    def budget_tag
      Tag.new(name: object.budget_type, approved: true)
    end
  end
end
