# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  it { is_expected.to have_db_column(:title).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:description).of_type(:text).with_options(null: false) }
  it { is_expected.to have_db_column(:lat).of_type(:decimal) }
  it { is_expected.to have_db_column(:lng).of_type(:decimal) }
  it { is_expected.to have_db_column(:place).of_type(:text) }
  it { is_expected.to have_db_column(:budget_type).of_type(:string) }
  it { is_expected.to have_db_column(:status).of_type(:string).with_options(null: false, default: 'submitted') }
  it { is_expected.to have_db_column(:votes_count).of_type(:integer).with_options(null: false, default: 0) }
  it { is_expected.to have_db_column(:category_id).of_type(:integer).with_options(null: false) }
  it { is_expected.to have_db_column(:user_id).of_type(:integer).with_options(null: false) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

  it { is_expected.to belong_to(:category).with_foreign_key(:category_id) }
  it { is_expected.to belong_to(:user).with_foreign_key(:user_id) }
end
