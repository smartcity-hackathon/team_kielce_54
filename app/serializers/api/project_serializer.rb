# frozen_string_literal: true

module API
  class ProjectSerializer < ActiveModel::Serializer
    has_many :comments, serializer: CommentSerializer
    belongs_to :category, serializer: CategorySerializer
    belongs_to :user, serializer: UserSerializer

    attributes :id, :title, :description, :lat, :lng, :place, :is_archived,
               :status, :votes_count, :tags

    # rubocop:disable Naming/PredicateName
    def is_archived
      object.archived?
    end
    # rubocop:enable Naming/PredicateName

    def tags
      tags_to_serialize = object.tags
      tags_to_serialize += Array.wrap(budget_tag) if object.budget_type.present?

      ActiveModelSerializers::SerializableResource.new(
        tags_to_serialize,
        each_serializer: TagSerializer
      ).as_json
    end

    def budget_tag
      Tag.new(name: object.budget_type, approved: true)
    end
  end
end
