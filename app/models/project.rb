# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :category, foreign_key: :category_id, inverse_of: :projects
  belongs_to :user, foreign_key: :user_id, inverse_of: :projects
end
