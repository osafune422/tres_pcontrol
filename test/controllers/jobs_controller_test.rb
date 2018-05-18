require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest
  test "should get show_job" do
    get jobs_show_job_url
    assert_response :success
  end

end
