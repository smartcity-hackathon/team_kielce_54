# frozen_string_literal: true

module API
  class ProjectForm
    include ActiveModel::Model

    attr_reader :project

    validates :title, :description, :category, :user, presence: true
    validates :lat, :lng, numericality: true, allow_blank: true

    attr_accessor :title, :description, :lat, :lng, :place,
                  :tags, :category, :user

    def save
      with_transaction { valid? && save_project? && save_tags? }
    end

    private

    def with_transaction
      ActiveRecord::Base.transaction do
        begin
          yield
        rescue ActiveRecord::ActiveRecordError
          raise ActiveRecord::Rollback
        end
      end
    end

    def save_project?
      @project = Project.create(
        title: @title,
        description: @description,
        budget_type: budget_tag_name,
        lat: @lat,
        lng: @lng,
        place: @place,
        category: @category,
        user: @user
      )
    end

    def save_tags?
      tags_to_save = @tags.reject(&method(:budget_tag_filter))
      tags_to_save.each do |tag_hash|
        @project.tags << Tag.find_or_create_by!(name: tag_hash[:name])
      end

      true
    end

    def budget_tag_name
      budget_tag = @tags.find(&method(:budget_tag_filter))

      budget_tag[:name] if budget_tag
    end

    def budget_tag_filter(tag)
      Project.budget_types.key?(tag[:name].to_s)
    end
  end
end
