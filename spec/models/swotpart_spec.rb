require 'rails_helper'

RSpec.describe Swotpart, type: :model do
  let!(:plan) { FactoryBot.create(:plan) }
  it "Requires name" do
    swotpart_test = Swotpart.new(partname: "strength", plan_id: plan.id).save
    expect(swotpart_test).to eq(false)
  end

  it "Requires partname" do
    swotpart_test = Swotpart.new(name: "Normal Name", plan_id: plan.id).save
    expect(swotpart_test).to eq(false)
  end

  it "Should save successfully" do
    swotpart_test = Swotpart.new(name: "Normal Name", partname: "strength", plan_id: plan.id).save
    expect(swotpart_test).to eq(true)
  end
end
