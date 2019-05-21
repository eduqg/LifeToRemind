require 'rails_helper'

RSpec.describe Activity, type: :model do
  let!(:goal) { FactoryBot.create(:goal) }

  context "Validation tests" do
    it "Requires title" do
      activity_test = Activity.new(goal_id: goal.id).save
      expect(activity_test).to eq(false)
    end

    it "Should save successfully" do
      activity_test = Activity.new(title: "My activity", goal_id: goal.id).save
      expect(activity_test).to eq(true)
    end
  end
end
