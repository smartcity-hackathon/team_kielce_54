class CreateTagsProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :tags_projects do |t|
      t.belongs_to :tag, foreign_key: true
      t.belongs_to :project, foreign_key: true
    end

    add_index :tags_projects, [:tag_id, :project_id], unique: true
  end
end
