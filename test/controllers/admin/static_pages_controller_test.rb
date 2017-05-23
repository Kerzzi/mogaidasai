require 'test_helper'

class Admin::StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get admin_static_pages_about_url
    assert_response :success
  end

end
