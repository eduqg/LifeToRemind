require 'rails_helper'

RSpec.describe Role, type: :model do
  let!(:plan) {FactoryBot.create(:plan)}

  context "Validation tests" do
    it "Requires plan_id" do
      role_test = Role.new(name: "Mae", description: "Ser uma boa mae").save
      expect(role_test).to eq(false)
    end

    it "Requires name" do
      role_test = Role.new(description: "Ser uma boa mae",plan_id: plan.id).save
      expect(role_test).to eq(false)
    end

    it "Requires description" do
      role_test = Role.new(name: "Mae", plan_id: plan.id).save
      expect(role_test).to eq(false)
    end

    it "Should save successfully" do
      role_test = Role.new(name: "Mae", description: "Ser uma boa mae", plan_id: plan.id).save
      expect(role_test).to eq(true)
    end
  end
end
