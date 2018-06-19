# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:approved).of_type(:boolean).with_options(null: false) }
  it { is_expected.to have_db_index(:name).unique(true) }

  it { is_expected.to have_many(:tags_projects).dependent(:destroy) }
  it { is_expected.to have_many(:projects).through(:tags_projects) }
end
