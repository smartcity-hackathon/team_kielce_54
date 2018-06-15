# frozen_string_literal: true

module API
  class BaseController < ActionController::Base
    protect_from_forgery with: :null_session

    def paginate(relation:, page:, per_page:)
      relation.offset(page - 1).limit(per_page)
    end
  end
end
