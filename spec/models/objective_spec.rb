require 'rails_helper'

RSpec.describe Objective, type: :model do
  let!(:plan) {FactoryBot.create(:plan)}
  let!(:sphere) {FactoryBot.create(:sphere)}

  context "Validation tests" do
    it "Plan name with more than 30 characters" do
      objective_test = Objective.new(name: "ReallybignameReallybignameReallybignameReallybigname", plan_id: plan.id).save
      expect(objective_test).to eq(false)
    end

    it "Plan name with less than 4 characters" do
      objective_test = Objective.new(name: "Rea", plan_id: plan.id).save
      expect(objective_test).to eq(false)
    end

    it "Requires user_id" do
      objective_test = Objective.new(name: "ReallyNotNormalName").save
      expect(objective_test).to eq(false)
    end

    it "Requires name" do
      objective_test = Objective.new(plan_id: plan.id).save
      expect(objective_test).to eq(false)
    end

    it "Should save successfully" do
      objective_test = Objective.new(name: "ReallyNormalName", plan_id: plan.id, sphere_id: sphere.id).save
      expect(objective_test).to eq(true)
    end
  end
end
