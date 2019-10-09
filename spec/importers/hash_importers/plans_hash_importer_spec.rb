require 'rails_helper'

RSpec.describe HashImporters::PlansHashImporter, type: :importer do
  let!(:user) {FactoryBot.create(:user)}
  let!(:hash) {JSON.parse(File.read('spec/fixtures/valid_simple_file_test.json')).deep_symbolize_keys}

  context "Import tests" do
    it 'imports hash object with nested relations' do
      expect { import_hash }
        .to change { Mission.count }.by(1)
        .and change { Vision.count }.by(1)
        .and change { Csf.count }.by(1)
        .and change { Sphere.count }.by(1)
        .and change { Plan.count }.by(1)
        .and change { Swotpart.count }.by(4)
        .and change { Value.count }.by(1)
        .and change { Role.count }.by(1)
        .and change { Objective.count }.by(1)
        .and change { Goal.count }.by(1)
        .and change { Activity.count }.by(1)
    end

    it 'allows an opts hash to override user_id in fixture' do
      import_hash

      [Mission, Vision, Csf, Sphere, Plan].each do |model|
        expect(model.where(user_id: user.id)).to_not be_empty
      end
    end

    it 'imports descendants when passed a nested hash' do
      import_hash
      goal_id = Plan.find_by(user: user).objectives.first.goals.first.id

      expect(Activity.where(goal_id: goal_id)).to_not be_empty
    end

    it 'allows the import of non-nested hashes' do
      shallow_hash = hash.slice(:missions)
      expect { import_hash(shallow_hash) }
        .to change { Mission.count }.by(1)
        .and change { Plan.count }.by(0)
        .and change { Swotpart.count }.by(0)
    end
  end

  private

  def import_hash(_hash = hash)
    HashImporters::PlansHashImporter.import(_hash, user_id: user.id)
  end
end
