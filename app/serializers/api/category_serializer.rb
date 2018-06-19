# frozen_string_literal: true

module API
  class CategorySerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end
