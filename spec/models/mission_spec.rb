require 'rails_helper'

RSpec.describe Mission, type: :model do
  let!(:plan) {FactoryBot.create(:plan)}

  context "Validation tests" do
    it "Requires why_exist" do
      mission_test = Mission.new(why_exist:"why", purpose_of_life:"purpose", plan_id: plan.id).save
      expect(mission_test).to eq(false)
    end
    it "Requires purpose_of_life" do
      mission_test = Mission.new(why_exist: "why", who_am_i:"who", plan_id: plan.id).save
      expect(mission_test).to eq(false)
    end
    it "Requires who_am_i" do
      mission_test = Mission.new(why_exist: "why", purpose_of_life:"purpose", plan_id: plan.id).save
      expect(mission_test).to eq(false)
    end
    it "Should save successfully" do
      mission_test = Mission.new(why_exist: "why", purpose_of_life:"purpose", who_am_i:"who", plan_id: plan.id).save
      expect(mission_test).to eq(true)
    end
  end
end
