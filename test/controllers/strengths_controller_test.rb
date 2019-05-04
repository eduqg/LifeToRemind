require 'test_helper'

class StrengthsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @strength = strengths(:one)
  end

  test "should get index" do
    get strengths_url
    assert_response :success
  end

  test "should get new" do
    get new_strength_url
    assert_response :success
  end

  test "should create strength" do
    assert_difference('Strength.count') do
      post strengths_url, params: { strength: { name: @strength.name, plan_id: @strength.plan_id } }
    end

    assert_redirected_to strength_url(Strength.last)
  end

  test "should show strength" do
    get strength_url(@strength)
    assert_response :success
  end

  test "should get edit" do
    get edit_strength_url(@strength)
    assert_response :success
  end

  test "should update strength" do
    patch strength_url(@strength), params: { strength: { name: @strength.name, plan_id: @strength.plan_id } }
    assert_redirected_to strength_url(@strength)
  end

  test "should destroy strength" do
    assert_difference('Strength.count', -1) do
      delete strength_url(@strength)
    end

    assert_redirected_to strengths_url
  end
end
