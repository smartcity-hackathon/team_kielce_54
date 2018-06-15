# frozen_string_literal: true

module API
  class ProjectSerializer < ActiveModel::Serializer
    belongs_to :category, serializer: CategorySerializer
    belongs_to :user, serializer: UserSerializer

    attributes :title, :description, :lat, :lng, :place,
               :status, :votes_count
  end
end
