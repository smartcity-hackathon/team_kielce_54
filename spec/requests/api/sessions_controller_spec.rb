# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::SessionsController, type: :request do
  describe 'POST #create' do
    context 'when user is not found via email' do
      it 'is 404 not found' do
        post '/api/sessions', params: { email: 'test@absent.com', password: 'test123' }

        expect(response).to be_not_found
      end
    end

    context 'when user was found, but passwords do not match' do
      it 'is 401 unauthorized' do
        User.create(
          email: 'test@example.com',
          password: 'test123',
          username: 'test'
        )

        post '/api/sessions', params: { email: 'test@example.com', password: 'wrong' }

        expect(response).to be_unauthorized
      end
    end

    it 'returns jsoned token' do
      User.create(
        email: 'test@example.com',
        password: 'test123',
        username: 'test'
      )
      mock_token = 'abcdef'

      allow(Users::JWTAuth).to receive(:token_for_user).with(User).and_return(mock_token)
      post '/api/sessions', params: { email: 'test@example.com', password: 'test123' }

      expect(response).to be_created
      expect(response.parsed_body).to eq('token' => mock_token)
    end
  end
end
