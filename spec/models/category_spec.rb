# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category do
  it { is_expected.to have_db_column(:name).with_options(null: false) }
end
