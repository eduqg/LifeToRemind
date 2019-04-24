require "application_system_test_case"

class PlansTest < ApplicationSystemTestCase
  setup do
    @plan = plans(:one)
  end

  test "visiting the index" do
    visit plans_url
    assert_selector "h1", text: "Plans"
  end

  test "creating a Plan" do
    visit plans_url
    click_on "New Plan"

    fill_in "Critical success factors selected", with: @plan.critical_success_factors_selected
    fill_in "Life objective", with: @plan.life_objective
    fill_in "Selected mission", with: @plan.selected_mission
    fill_in "Selected vision", with: @plan.selected_vision
    click_on "Create Plan"

    assert_text "Plan was successfully created"
    click_on "Back"
  end

  test "updating a Plan" do
    visit plans_url
    click_on "Edit", match: :first

    fill_in "Critical success factors selected", with: @plan.critical_success_factors_selected
    fill_in "Life objective", with: @plan.life_objective
    fill_in "Selected mission", with: @plan.selected_mission
    fill_in "Selected vision", with: @plan.selected_vision
    click_on "Update Plan"

    assert_text "Plan was successfully updated"
    click_on "Back"
  end

  test "destroying a Plan" do
    visit plans_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Plan was successfully destroyed"
  end
end
