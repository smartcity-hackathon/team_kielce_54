# frozen_string_literal: true

require 'rails_helper'
require 'support/controller_helpers'

RSpec.describe API::CommentsController, type: :request do
  include ControllerHelpers

  describe '#index' do
    it 'is successful and returns project\'s comments' do
      user = User.create(
        email: 'comment@ator.pl',
        username: 'c0mm3nt',
        password: 'talkat!v3'
      )
      category = Category.find_by(name: 'education')
      project = create_project(user, category)
      project.comments.create(content: 'cool one!', user: user)

      stub_sign_in_as(user)
      get "/api/categories/education/projects/#{project.id}/comments"

      expected_response = [{
        'content' => 'cool one!',
        'user'    => {
          'id'       => user.id,
          'username' =>  'c0mm3nt'
        }
      }]
      expect(response).to be_successful
      expect(response.parsed_body).to eq(expected_response)
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'creates comment and renders it' do
        user = User.create(
          email: 'comment@ator.pl',
          username: 'c0mm3nt',
          password: 'talkat!v3'
        )
        category = Category.find_by(name: 'education')
        project = create_project(user, category)

        stub_sign_in_as(user)
        expect do
          post "/api/categories/education/projects/#{project.id}/comments", params: { comment: { content: 'ha!' } }
        end.to change(project.comments, :count).by(1)

        expected_response = {
          'content' => 'ha!',
          'user' => {
            'id' => user.id,
            'username' => 'c0mm3nt'
          }
        }
        expect(response).to be_successful
        expect(response.parsed_body).to eq(expected_response)
      end
    end

    context 'with invalid params' do
      it 'does not create comment and is unprocessable entity' do
        user = User.create(
          email: 'comment@ator.pl',
          username: 'c0mm3nt',
          password: 'talkat!v3'
        )
        category = Category.find_by(name: 'education')
        project = create_project(user, category)

        stub_sign_in_as(user)
        expect do
          post "/api/categories/education/projects/#{project.id}/comments", params: { comment: { content: '' } }
        end.not_to change(project.comments, :count)

        expect(response).to be_unprocessable
        expect(response.parsed_body).to include('content' => ["can't be blank"])
      end
    end
  end
end
