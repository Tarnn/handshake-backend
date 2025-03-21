require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  fixtures :users
  
  setup do
    @headers = { 'Authorization' => 'your-secret-token' }
    @jim = users(:jim)
    @sally = users(:sally)
  end

  test 'should get index' do
    expected_users = [
      { 'id' => @jim.id, 'first_name' => 'Jim', 'last_name' => 'Hawkins', 'check_in_time' => @jim.check_in_time.as_json },
      { 'id' => @sally.id, 'first_name' => 'Sally', 'last_name' => 'Ride', 'check_in_time' => @sally.check_in_time.as_json }
    ]
    
    UserService.stub :fetch_all_users, [@jim, @sally] do
      get '/index', headers: @headers
      assert_response :success, "Expected successful response"

      users = JSON.parse(response.body)
      assert_equal expected_users, users, "Response should match expected users"
    end
  end

  test 'should handle errors gracefully' do
    # Use stub to temporarily override the method for this test only
    UserService.stub :fetch_all_users, ->{ raise StandardError, "Test error" } do
      get '/index', headers: @headers
      assert_response :internal_server_error, "Should return 500 status code on error"
      
      json_response = JSON.parse(response.body)
      assert_includes json_response["errors"]["base"], "Error fetching users", "Error message should be present"
    end
  end

  test "should require authentication" do
    get '/index', headers: {}
    assert_response :unauthorized
  end
  
  test "should allow access with valid token" do
    get '/index', headers: { 'Authorization' => 'Bearer your-secret-token' }
    assert_response :success
  end
end 