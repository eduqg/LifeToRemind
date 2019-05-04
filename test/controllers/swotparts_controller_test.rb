require 'test_helper'

class SwotpartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @swotpart = swotparts(:one)
  end

  test "should get index" do
    get swotparts_url
    assert_response :success
  end

  test "should get new" do
    get new_swotpart_url
    assert_response :success
  end

  test "should create swotpart" do
    assert_difference('swotpart.count') do
      post swotparts_url, params: { swotpart: { name: @swotpart.name, plan_id: @swotpart.plan_id } }
    end

    assert_redirected_to swotpart_url(Swotpart.last)
  end

  test "should show swotpart" do
    get swotpart_url(@swotpart)
    assert_response :success
  end

  test "should get edit" do
    get edit_swotpart_url(@swotpart)
    assert_response :success
  end

  test "should update swotpart" do
    patch swotpart_url(@swotpart), params: { swotpart: { name: @swotpart.name, plan_id: @swotpart.plan_id } }
    assert_redirected_to swotpart_url(@swotpart)
  end

  test "should destroy swotpart" do
    assert_difference('swotpart.count', -1) do
      delete swotpart_url(@swotpart)
    end

    assert_redirected_to swotparts_url
  end
end
