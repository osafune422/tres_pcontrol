require 'test_helper'

class AttendsControllerTest < ActionDispatch::IntegrationTest
  test "should get attendall" do
    get attends_attendall_url
    assert_response :success
  end

end
