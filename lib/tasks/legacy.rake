# frozen_string_literal: true

require 'legacy/csv_parser'

namespace :legacy do
  desc 'Imports CSVs from past years into the system'
  task import: :environment do
    projects = import_for_year(2016) + import_for_year(2017)
    ActiveRecord::Base.transaction do
      projects.each(&:save!)
    end
  end

  def import_for_year(year)
    path = Rails.root.join('db', 'legacy', "budzet-obywatelski-#{year}.csv")
    import = Legacy::CSVParser.new(file_path: path, from_year: year)

    import.parse
  end
end
