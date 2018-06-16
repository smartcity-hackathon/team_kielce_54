# frozen_string_literal: true

module API
  class BaseController < ActionController::Base
    include Pundit

    protect_from_forgery with: :null_session

    rescue_from Pundit::NotAuthorizedError, with: -> { head :forbidden }

    def paginate(relation:, page:, per_page:)
      relation.offset(page - 1).limit(per_page)
    end

    def current_user
      User.last
    end
  end
end
