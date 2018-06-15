# frozen_string_literal: true

module API
  class ProjectSerializer < ActiveModel::Serializer
    belongs_to :category, serializer: CategorySerializer
    belongs_to :user, serializer: UserSerializer

    attributes :title, :description, :lat, :lng, :place,
               :status, :votes_count, :tags

    def tags
      ActiveModel::SerializableResource.new(
        object.tags.push(budget_tag),
        each_serializer: TagSerializer
      ).as_json
    end

    def budget_tag
      Tag.new(name: object.budget_type, approved: true)
    end
  end
end
