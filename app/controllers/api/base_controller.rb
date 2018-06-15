# frozen_string_literal: true

module API
  class BaseController < ActionController::Base
    protect_from_forgery with: :null_session
  end
end
