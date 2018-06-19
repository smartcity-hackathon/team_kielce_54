# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::ProjectForm, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:category) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_numericality_of(:lat).allow_nil }
  it { is_expected.to validate_numericality_of(:lng).allow_nil }

  describe '#save' do
    context 'when budget tag is not present' do
      it 'saves the project and other tags' do
        # provided by seed fu
        user           = User.first
        category       = Category.first
        project_params = {
          title: 'super project',
          description: 'water park',
          category: category,
          user: user,
          tags: [{ name: 'Kate Moss' }]
        }

        form = described_class.new(project_params)
        result = form.save

        expect(result).to be true
        expect(Tag.find_by(name: 'Kate Moss')).to be_present
        expect(form.project).to be_persisted
        expect(form.project.budget_type).to be_nil
      end
    end

    context 'when budget tag is present' do
      it 'saves the project and the tags, but "budget tag" is not saved' do
        # provided by seed fu
        user           = User.first
        category       = Category.first
        project_params = {
          title: 'super project',
          description: 'water park',
          category: category,
          user: user,
          tags: [
            { name: 'Kate Moss' },
            { name: 'big' }
          ]
        }

        form = described_class.new(project_params)
        result = form.save

        expect(result).to be true
        expect(Tag.find_by(name: 'Kate Moss')).to be_persisted
        expect(form.project).to be_persisted
        expect(form.project).to be_big
      end
    end

    context 'when sent with invalid tag' do
      it 'does not save project to DB and is false' do
        # provided by seed fu
        user           = User.first
        category       = Category.first
        project_params = {
          title: 'super project',
          description: 'water park',
          category: category,
          user: user,
          tags: [
            { name: 'Kate Moss' },
            { name: '' }
          ]
        }

        form = described_class.new(project_params)
        result = form.save

        expect(result).to be_falsy
        expect(Tag.find_by(name: 'Kate Moss')).not_to be_present
        expect(form.project).not_to be_persisted
      end
    end
  end
end
