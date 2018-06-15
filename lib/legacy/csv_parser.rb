# frozen_string_literal: true

require 'csv'

# :nocov:
# rubocop:disable all
module Legacy
  class CSVParser
    def initialize(file_path:, from_year:)
      @csv = CSV.open(file_path, headers: true)
      @legacy_year = Date.new.change(year: from_year)
      @mock_users = User.where(id: (1..3))
      @categories = Category.all
    end

    def parse
      @projects ||= @csv.map(&method(:parse_row))
    end

    def parse_row(row)
      project = Project.new
      project.title = row['NAZWA']
      project.description = row['NAZWA']
      project.lat = parse_coordinate(row['LAT'])
      project.lng = parse_coordinate(row['LNG'])
      project.place = row['PROPONOWANA LOKALIZACJA']
      project.budget_type = parse_budget_type(row['RODZAJ PROJEKTU (DUŻE/MAŁE)'])
      project.votes_count = row['SUMA GŁOSÓW WAŻNYCH'].to_i
      project.created_at = @legacy_year
      project.user = @mock_users.sample
      project.category = @categories.sample
      project.status = assign_status(project)

      project
    end

    private

    def parse_coordinate(string_coordinate)
      BigDecimal(string_coordinate) if string_coordinate.present?
    end

    def parse_budget_type(budget_string)
      if budget_string.blank?
        nil
      elsif /duże/i.match?(budget_string)
        Project.budget_types[:big]
      elsif /małe/i.match?(budget_string)
        Project.budget_types[:small]
      end
    end

    def assign_status(project)
      if project.votes_count.zero?
        Project.statuses[:rejected]
      else
        Project.statuses[:ready_for_city_voting]
      end
    end
  end
end
