require 'rails_helper'

RSpec.describe Csf, type: :model do

  let!(:user) {FactoryBot.create(:user)}

  context "Validation tests" do
    it "Requires what_makes_me_unique" do
      csf_test = Csf.new(best_attributes: "how", essential_atributes: "sdlkmsdkfm", health_factors:"slkmsdfk" ,user_id: user.id).save
      expect(csf_test).to eq(false)
    end
    it "Requires best_attributes" do
      csf_test = Csf.new(what_makes_me_unique: "where", essential_atributes: "sdlkmsdkfm", health_factors:"slkmsdfk", user_id: user.id).save
      expect(csf_test).to eq(false)
    end
    it "Requires essential_atributes" do
      csf_test = Csf.new(what_makes_me_unique: "where", best_attributes: "how", health_factors:"slkmsdfk", user_id: user.id).save
      expect(csf_test).to eq(false)
    end
    it "Requires health_factors" do
      csf_test = Csf.new(what_makes_me_unique: "where", best_attributes: "how", essential_atributes: "sdlkmsdkfm", user_id: user.id).save
      expect(csf_test).to eq(false)
    end
    it "Should save successfully" do
      csf_test = Csf.new(what_makes_me_unique: "where", best_attributes: "how", essential_atributes: "sdlkmsdkfm", health_factors:"slkmsdfk", user_id: user.id).save
      expect(csf_test).to eq(true)
    end
  end
end