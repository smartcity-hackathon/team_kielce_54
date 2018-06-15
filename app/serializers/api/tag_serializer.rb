# frozen_string_literal: true

module API
  class TagSerializer < ActiveModel::Serializer
    attributes :name
  end
end
