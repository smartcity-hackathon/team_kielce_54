# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagsProject, type: :model do
  it { is_expected.to belong_to(:project).with_foreign_key(:project_id) }
  it { is_expected.to belong_to(:tag).with_foreign_key(:tag_id) }
end
