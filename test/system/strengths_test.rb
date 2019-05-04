require "application_system_test_case"

class StrengthsTest < ApplicationSystemTestCase
  setup do
    @strength = strengths(:one)
  end

  test "visiting the index" do
    visit strengths_url
    assert_selector "h1", text: "Strengths"
  end

  test "creating a Strength" do
    visit strengths_url
    click_on "New Strength"

    fill_in "Name", with: @strength.name
    fill_in "Plan", with: @strength.plan_id
    click_on "Create Strength"

    assert_text "Strength was successfully created"
    click_on "Back"
  end

  test "updating a Strength" do
    visit strengths_url
    click_on "Edit", match: :first

    fill_in "Name", with: @strength.name
    fill_in "Plan", with: @strength.plan_id
    click_on "Update Strength"

    assert_text "Strength was successfully updated"
    click_on "Back"
  end

  test "destroying a Strength" do
    visit strengths_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Strength was successfully destroyed"
  end
end
