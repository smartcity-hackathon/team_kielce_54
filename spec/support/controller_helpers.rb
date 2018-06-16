# frozen_string_literal: true

module ControllerHelpers
  def stub_sign_in_as(user)
    allow_any_instance_of(API::BaseController).to receive(:current_user).and_return(user)
  end
end
