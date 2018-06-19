# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :project, inverse_of: :comments, foreign_key: :project_id
  belongs_to :user, inverse_of: :comments, foreign_key: :user_id
end
