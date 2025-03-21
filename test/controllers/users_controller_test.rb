require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  fixtures :users
  
  setup do
    @headers = { 'Authorization' => 'your-secret-token' }
    @jim = users(:jim)
    @sally = users(:sally)
  end

  test 'should get index' do
    get '/index', headers: @headers
    assert_response :success, "Expected successful response"

    users = JSON.parse(response.body)
    assert_kind_of Array, users, "Response should be an array"
    assert_equal 2, users.length, "Should have exactly 2 users"
    
    # Test first user
    assert_equal 'Jim', users[0]['first_name'], "First user's first name should be Jim"
    assert_equal 'Hawkins', users[0]['last_name'], "First user's last name should be Hawkins"
    
    # Test second user
    assert_equal 'Sally', users[1]['first_name'], "Second user's first name should be Sally"
    assert_equal 'Ride', users[1]['last_name'], "Second user's last name should be Ride"
  end

  test 'should handle errors gracefully' do
    # Override the UserService method to raise an error
    def UserService.fetch_all_users
      raise StandardError, "Test error"
    end
    
    get '/index', headers: @headers
    assert_response :internal_server_error, "Should return 500 status code on error"
    
    json_response = JSON.parse(response.body)
    assert_includes json_response["errors"]["base"], "Error fetching users", "Error message should be present"
  end

  # Uncomment these tests when authentication is enabled
  # test "should require authentication" do
  #   get users_url
  #   assert_response :unauthorized
  # end
  #
  # test "should allow access with valid token" do
  #   get users_url, headers: { 'Authorization' => 'Bearer your-secret-token' }
  #   assert_response :success
  # end
end 