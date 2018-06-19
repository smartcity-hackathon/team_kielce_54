# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:username).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_index(:email).unique(true) }
  it { is_expected.to have_db_index(:username).unique(true) }

  it { is_expected.to have_many(:projects).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }

  describe 'secure password' do
    it 'has encrypted password' do
      user = User.new(email: 'test@example.com', username: 'test', password: 's0hard!')

      user.save

      expect(user.reload.password).to eq('s0hard!')
      expect(user.encrypted_password).to be_a(String)
    end
  end
end
