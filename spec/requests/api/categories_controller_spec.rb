# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::CategoriesController, type: :request do
  describe 'GET #index' do
    it 'is success and returns jsoned categories' do
      expected_response = [
        { id: 1, name: 'sport' },
        { id: 2, name: 'education' },
        { id: 3, name: 'entertainment' },
        { id: 4, name: 'infrastructure' },
        { id: 5, name: 'technology' }
      ].map(&:stringify_keys)

      get '/api/categories'

      expect(response).to be_successful
      expect(response.parsed_body).to eq(expected_response)
    end
  end
end
