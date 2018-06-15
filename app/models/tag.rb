# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :tags_projects, dependent: :destroy
  has_many :projects, through: :tags_projects
end
