# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::ProjectsController, type: :request do
  describe 'GET #index' do
    it 'is success and returns jsoned projects' do
      sport_category = Category.find_by(name: 'sport')
      user = User.create(
        username: 'testuser',
        email: 'test@example.com',
        password: 's0hard!'
      )
      project = Project.create(
        title: 'Test Project',
        description: 'tasty test',
        lat: nil,
        lng: nil,
        place: 'marketplace',
        budget_type: Project.budget_types[:small],
        votes_count: 5,
        category: sport_category,
        user: user
      )
      Comment.create(
        content: 'great project!',
        project: project,
        user: user
      )
      expected_response = [{
        'title'       => 'Test Project',
        'description' => 'tasty test',
        'lat'         => nil,
        'lng'         => nil,
        'place'       => 'marketplace',
        'votes_count' => 5,
        'status'      => 'submitted',
        'category'    => {
          'id'   => sport_category.id,
          'name' => sport_category.name
        },
        'user' => {
          'id'       => user.id,
          'username' => user.username
        },
        'tags' => [
          { 'name' => 'small' }
        ],
        'comments' => [{
          'content' => 'great project!',
          'user' => {
            'id'       => user.id,
            'username' => user.username
          }
        }]
      }]

      get '/api/categories/sport/projects', params: { per_page: 2, page: 1 }

      expect(response).to be_successful
      expect(response.parsed_body).to eq(expected_response)
    end
  end
end
