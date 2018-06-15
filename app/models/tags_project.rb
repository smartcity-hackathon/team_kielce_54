# frozen_string_literal: true

class TagsProject < ApplicationRecord
  belongs_to :tag, foreign_key: :tag_id, inverse_of: :tags_projects
  belongs_to :project, foreign_key: :project_id, inverse_of: :tags_projects
end
