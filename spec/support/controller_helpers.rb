# frozen_string_literal: true

module ControllerHelpers
  def stub_sign_in_as(user)
    allow_any_instance_of(API::BaseController).to receive(:current_user).and_return(user)
  end

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
end
