# frozen_string_literal: true

module API
  class CategoriesController < BaseController
    def index
      categories = Category.all
      render json: categories
    end
  end
end
