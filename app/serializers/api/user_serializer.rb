# frozen_string_literal: true

module API
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :username
  end
end
