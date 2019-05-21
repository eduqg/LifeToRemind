require 'rails_helper'

RSpec.describe Goal, type: :model do
  let!(:objective) {FactoryBot.create(:objective)}

  context "Validation tests" do
    it "Requires name" do
      goal_test = Goal.new(objective_id: objective.id).save
      expect(goal_test).to eq(false)
    end

    it "Should save successfully" do
      goal_test = Goal.new(name: "My goal", objective_id: objective.id).save
      expect(goal_test).to eq(true)
    end
  end
end
