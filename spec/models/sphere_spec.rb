require "rails_helper"

RSpec.describe Sphere, type: :model do
  let!(:user) {FactoryBot.create(:user)}

  context "Validation tests" do
    it "Plan name with more than 30 characters" do
      sphere_test = Sphere.new(name: "ReallybignameReallybignameReallybignameReallybigname", user_id: user.id).save
      expect(sphere_test).to eq(false)
    end

    it "Plan name with less than 4 characters" do
      sphere_test = Sphere.new(name: "Rea", user_id: user.id).save
      expect(sphere_test).to eq(false)
    end

    it "Requires user_id" do
      sphere_test = Sphere.new(name: "ReallyNotNormalName").save
      expect(sphere_test).to eq(false)
    end

    it "Requires name" do
      sphere_test = Sphere.new(user_id: user.id).save
      expect(sphere_test).to eq(false)
    end

    it "Should save successfully" do
      sphere_test = Sphere.new(name: "ReallyNormalName", user_id: user.id).save
      expect(sphere_test).to eq(true)
    end
  end
end