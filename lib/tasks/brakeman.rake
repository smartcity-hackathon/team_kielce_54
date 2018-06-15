# frozen_string_literal: true

namespace :brakeman do
  desc 'Check your code with Brakeman'
  task :check do
    require 'brakeman'
    result = Brakeman.run app_path: '.', print_report: true
    exit Brakeman::Warnings_Found_Exit_Code if result.filtered_warnings.present?
  end
end
