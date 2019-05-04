require "application_system_test_case"

class SwotpartsTest < ApplicationSystemTestCase
  setup do
    @swotpart = swotparts(:one)
  end

  test "visiting the index" do
    visit swotparts_url
    assert_selector "h1", text: "swotparts"
  end

  test "creating a swotpart" do
    visit swotparts_url
    click_on "New swotpart"

    fill_in "Name", with: @swotpart.name
    fill_in "Plan", with: @swotpart.plan_id
    click_on "Create swotpart"

    assert_text "swotpart was successfully created"
    click_on "Back"
  end

  test "updating a swotpart" do
    visit swotparts_url
    click_on "Edit", match: :first

    fill_in "Name", with: @swotpart.name
    fill_in "Plan", with: @swotpart.plan_id
    click_on "Update swotpart"

    assert_text "swotpart was successfully updated"
    click_on "Back"
  end

  test "destroying a swotpart" do
    visit swotparts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "swotpart was successfully destroyed"
  end
end
