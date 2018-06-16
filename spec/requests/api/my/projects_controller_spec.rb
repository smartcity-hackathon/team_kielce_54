# frozen_string_literal: true

require 'rails_helper'
require 'support/controller_helpers'

RSpec.describe API::My::ProjectsController, type: :request do
  include ControllerHelpers

  def create_project(user, category)
    Project.create(
      title: 'Test Project',
      description: 'tasty test',
      lat: nil, lng: nil,
      place: 'marketplace',
      budget_type: Project.budget_types[:small],
      votes_count: 5,
      category: category,
      user: user
    )
  end

  describe 'GET #index' do
    it 'is successful and returns current user\'s projects' do
      user = User.create(
        email: 'test@example.com',
        username: 'tastytest',
        password: 'test123'
      )
      other_user = User.create(
        email: 'other@email.com',
        username: 'notsotasty',
        password: 'test123'
      )
      category = Category.find_by(name: 'education')
      2.times { create_project(user, category) }
      create_project(other_user, category)

      stub_sign_in_as(user)
      get '/api/my/projects'

      expect(response).to be_successful
      expect(response.parsed_body.length).to eq(2)
    end
  end
end
