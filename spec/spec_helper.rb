# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'vendor'
  add_filter 'application_[record|mailer|job]+\.rb'

  add_group 'Libraries', 'lib'
end

SimpleCov.minimum_coverage 100

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.default_formatter = 'doc' if config.files_to_run.one?
  config.disable_monkey_patching!
  config.example_status_persistence_file_path = 'tmp/rspec-status-cache.txt'
  config.filter_run_when_matching :focus
  config.profile_examples = 5
  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.order = :random
  Kernel.srand config.seed
end
