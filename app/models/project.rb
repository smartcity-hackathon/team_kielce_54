# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :tags_projects, dependent: :destroy
  has_many :tags, through: :tags_projects
  has_many :comments, dependent: :destroy
  belongs_to :category, foreign_key: :category_id, inverse_of: :projects
  belongs_to :user, foreign_key: :user_id, inverse_of: :projects

  enum budget_type: {
    small: 'small',
    big: 'big'
  }

  enum status: {
    submitted: 'submitted',
    accepted: 'accepted',
    ready_for_voting: 'ready_for_voting',
    voted_in_category: 'voted_in_category',
    ready_for_city_voting: 'ready_for_city_voting',
    rejected: 'rejected'
  }

  def self.archived
    where('EXTRACT(YEAR FROM created_at) < EXTRACT(YEAR FROM now())')
  end
end
