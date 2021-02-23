require 'test_helper'

class OutputsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get outputs_index_url
    assert_response :success
  end

  test "should get show" do
    get outputs_show_url
    assert_response :success
  end

  test "should get new" do
    get outputs_new_url
    assert_response :success
  end

  test "should get edit" do
    get outputs_edit_url
    assert_response :success
  end

end
