require "rails_helper"

RSpec.describe Plan, type: :model do
  let!(:user) {FactoryBot.create(:user)}

  context "Validation tests" do
    it "Plan name with more than 30 characters" do
      plan_test = Plan.new(name: "ReallybignameReallybignameReallybignameReallybigname", user_id: user.id).save
      expect(plan_test).to eq(false)
    end

    it "Plan name with less than 4 characters" do
      plan_test = Plan.new(name: "Rea", user_id: user.id).save
      expect(plan_test).to eq(false)
    end

    it "Requires user_id" do
      plan_test = Plan.new(name: "ReallyNotNormalName").save
      expect(plan_test).to eq(false)
    end

    it "Requires name" do
      plan_test = Plan.new(user_id: user.id).save
      expect(plan_test).to eq(false)
    end

    it "Should save successfully" do
      plan_test = Plan.new(name: "ReallyNormalName", user_id: user.id).save
      expect(plan_test).to eq(true)
    end
  end
end