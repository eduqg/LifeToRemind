require 'rails_helper'

RSpec.describe Value, type: :model do
  let!(:plan) {FactoryBot.create(:plan)}

  context "Validation tests" do
    it "Requires plan_id" do
      value_test = Value.new(name: "ReallyNotNormalName").save
      expect(value_test).to eq(false)
    end

    it "Requires name" do
      value_test = Value.new(plan_id: plan.id).save
      expect(value_test).to eq(false)
    end

    it "Should save successfully" do
      value_test = Value.new(name: "ReallyNormalName", plan_id: plan.id).save
      expect(value_test).to eq(true)
    end
  end
end
