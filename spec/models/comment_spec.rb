# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to belong_to(:user).with_foreign_key(:user_id) }
  it { is_expected.to belong_to(:project).with_foreign_key(:project_id) }
end
