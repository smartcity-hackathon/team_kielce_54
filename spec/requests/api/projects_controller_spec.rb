# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::ProjectsController, type: :request do
  def stub_sign_in_as(user)
    allow_any_instance_of(API::BaseController).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    context 'when category does not exist' do
      it 'is 404 not found' do
        get '/api/categories/not-existing/projects'

        expect(response).to be_not_found
      end
    end

    context 'with correct budget type' do
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
          'id'          => project.id,
          'title'       => 'Test Project',
          'description' => 'tasty test',
          'lat'         => nil,
          'lng'         => nil,
          'place'       => 'marketplace',
          'votes_count' => 5,
          'status'      => 'submitted',
          'is_archived' => false,
          'category'    => {
            'id' => sport_category.id,
            'name' => sport_category.name
          },
          'user' => {
            'id' => user.id,
            'username' => user.username
          },
          'tags' => [
            { 'name' => 'small' }
          ],
          'comments' => [{
            'content' => 'great project!',
            'user' => {
              'id' => user.id,
              'username' => user.username
            }
          }]
        }]

        get '/api/categories/sport/projects', params: { per_page: 2, page: 1 }

        expect(response).to be_successful
        expect(response.parsed_body).to eq(expected_response)
      end
    end

    context 'with null budget_type and no other tags' do
      context 'when category does not exist' do
        it 'is 404 not found' do
          get '/api/categories/not-existing/projects'

          expect(response).to be_not_found
        end
      end

      it 'is still success, but tags are empty array' do
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
          budget_type: nil,
          votes_count: 5,
          category: sport_category,
          user: user
        )
        expected_response = [{
          'id'          => project.id,
          'title'       => 'Test Project',
          'description' => 'tasty test',
          'lat'         => nil,
          'lng'         => nil,
          'place'       => 'marketplace',
          'votes_count' => 5,
          'status'      => 'submitted',
          'is_archived' => false,
          'category'    => {
            'id' => sport_category.id,
            'name' => sport_category.name
          },
          'user' => {
            'id' => user.id,
            'username' => user.username
          },
          'tags' => [],
          'comments' => []
        }]

        get '/api/categories/sport/projects', params: { per_page: 2, page: 1 }

        expect(response).to be_successful
        expect(response.parsed_body).to eq(expected_response)
      end
    end
  end

  describe 'GET #archived' do
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
        user: user,
        created_at: Date.new.change(year: 1.year.ago.year)
      )
      Comment.create(
        content: 'great project!',
        project: project,
        user: user
      )
      expected_response = [{
        'id'          => project.id,
        'title'       => 'Test Project',
        'description' => 'tasty test',
        'lat'         => nil,
        'lng'         => nil,
        'place'       => 'marketplace',
        'votes_count' => 5,
        'status'      => 'submitted',
        'is_archived' => true,
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

      get '/api/categories/sport/projects/archived', params: { per_page: 2, page: 1 }

      expect(response).to be_successful
      expect(response.parsed_body).to eq(expected_response)
    end
  end

  describe 'GET #show' do
    context 'when category does not exist' do
      it 'is 404 not found' do
        get '/api/categories/not-existing/projects'

        expect(response).to be_not_found
      end
    end

    it 'is success and returns jsoned project' do
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
        user: user,
        created_at: Date.new.change(year: 1.year.ago.year)
      )
      Comment.create(
        content: 'great project!',
        project: project,
        user: user
      )
      expected_response = {
        'id'          => project.id,
        'title'       => 'Test Project',
        'description' => 'tasty test',
        'lat'         => nil,
        'lng'         => nil,
        'place'       => 'marketplace',
        'votes_count' => 5,
        'status'      => 'submitted',
        'is_archived' => true,
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
      }

      get "/api/categories/sport/projects/#{project.id}"

      expect(response).to be_successful
      expect(response.parsed_body).to eq(expected_response)
    end
  end

  describe 'POST #create' do
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

    context 'when user already created 3 other projects' do
      it 'is 403 forbiden' do
        sport_category = Category.find_by(name: 'sport')
        user = User.create(
          username: 'testuser',
          email: 'test@example.com',
          password: 's0hard!'
        )
        3.times { create_project(user, sport_category) }

        stub_sign_in_as(user)
        post '/api/categories/sport/projects', params: { project: { title: 'Cool one!' } }

        expect(response).to be_forbidden
      end
    end

    context 'when form fails to save' do
      it 'renders form errors as 422' do
        user = User.first

        stub_sign_in_as(user)
        post '/api/categories/sport/projects', params: { project: { title: '' } }

        expect(response).to be_unprocessable
        expect(response.parsed_body).to include('title' => ["can't be blank"])
      end
    end

    context 'when form saves successfuly' do
      it 'is created and renders project json' do
        sport_category = Category.find_by(name: 'sport')
        user           = User.first
        project_params = {
          title: 'super project',
          description: 'water park',
          category: sport_category,
          user: user,
          tags: [
            { name: 'Kate Moss' }
          ]
        }

        stub_sign_in_as(user)
        post '/api/categories/sport/projects', params: { project: project_params }

        expect(response).to be_created
        expect(response.parsed_body['tags'].length).to eq(1)
      end
    end
  end
end
