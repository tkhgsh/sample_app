require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invlalid signup information" do
    get signup_path
    assert_difference 'User.count',1 do 
    post users_path, params: { user: { name:  "test",
                                        email: "user@example.com",
                                        password: "foopassword",
                                        password_confirmation: "foopassword" } }
    end
    follow_redirect!
    assert_template 'users/show'
  end
  # test "the truth" do
  #   assert true
  # end
  
end
