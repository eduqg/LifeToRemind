require "rails_helper"

RSpec.describe User, type: :model do
  context "validation tests" do
    it "ensures email presence" do
      user = User.new(name:"Rogerio", password:"123456").save
      expect(user).to eq(false)
    end
    it "ensures name presence" do
      user = User.new(email: "rogerio@ltr.com", password:"123456").save
      expect(user).to eq(false)
    end
    it "ensures password presence" do
      user = User.new(name:"Rogerio", email: "rogerio@ltr.com").save
      expect(user).to eq(false)
    end
    it "should save successfully" do
      user = User.new(name:"Rogerio", password:"123456", email: "rogerio@ltr.com").save
      expect(user).to eq(true)
    end

  end
end
