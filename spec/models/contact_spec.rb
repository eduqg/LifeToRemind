require 'rails_helper'

RSpec.describe Activity, type: :model do
  context "Validation tests" do
    it "ensures email presence" do
      contact = Contact.new(name:"Luana", message:"heloooooo").save
      expect(contact).to eq(false)
    end
    it "ensures name presence" do
      contact = Contact.new(email: "luana@ltr.com", message:"heloooooo").save
      expect(contact).to eq(false)
    end
    it "ensures message presence" do
      contact = Contact.new(name:"Luana", email: "luana@ltr.com").save
      expect(contact).to eq(false)
    end
    it "ensures email to have correct format" do
      contact = Contact.new(name:"Luana", email: "luana", message:"Site muito bom!").save
      expect(contact).to eq(false)
    end

    it "should save successfully" do
      contact = Contact.new(name:"Carla", email:"carla@ltr.com", message:"Site muito bom!").save
      expect(contact).to eq(true)
    end
  end
end
