require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @current_user = users(:one)
  end

  test 'should get index' do
    get session_create_url, params: { login: 'admin', password: 'admin' }
    assert_redirected_to root_url
    get users_url
    assert_response :success
  end

  test 'should get new' do
    get new_user_url
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url, params: { user: { avatar: @user.avatar, password: 'user34',
                                        password_confirmation: 'user34', username: 'user34' } }
    end

    assert_response :redirect
  end

  test 'should show user' do
    get session_create_url, params: { login: 'user1', password: 'user1' }
    assert_redirected_to root_url

    get user_url(@user)
    assert_response :success
  end

  test 'should get edit' do
    get session_create_url, params: { login: 'user1', password: 'user1' }
    assert_redirected_to root_url

    get edit_user_url(@user)
    assert_response :success
  end

  test 'should update user' do
    get session_create_url, params: { login: 'user1', password: 'user1' }
    assert_redirected_to root_url

    patch user_url(@user), params: { user: { avatar: @user.avatar, username: 'user12',
                                             password: 'user12', password_confirmation: 'user12' } }
    assert_redirected_to user_url(@user)
  end

  test 'should destroy user' do
    get session_create_url, params: { login: 'user1', password: 'user1' }
    assert_redirected_to root_url

    delete user_url(@user)
    assert_redirected_to root_url
  end

  test 'should not see another user\'s account' do
    get session_login_url, params: { username: 'user1', password: 'user1', password_confirmation: 'user1'}
    assert_response :success
    user = users(:two)
    get user_url(user)
    assert_redirected_to root_url
  end

  test 'should not delete another user\'s account' do
    get session_login_url, params: { username: 'user1', password: 'user1', password_confirmation: 'user1'}
    assert_response :success
    user = users(:two)
    delete user_url(user)
    assert_redirected_to root_url
  end

  test 'should not update another user\'s account' do
    get session_login_url, params: { username: 'user1', password: 'user1', password_confirmation: 'user1'}
    assert_response :success
    user = users(:two)
    put user_url(user)
    assert_redirected_to root_url
  end
end
