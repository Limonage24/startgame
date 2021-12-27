require "test_helper"

class SessionsFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @post = posts(:one)
  end
  test 'unauthorized user cannot create/edit/update/delete posts' do
    post = posts(:one)
    get new_post_url
    assert_redirected_to root_url
    get edit_post_url(post)
    assert_redirected_to root_url
    put post_url(post)
    assert_redirected_to root_url
    delete post_url(post)
    assert_redirected_to root_url
  end

  test 'user with incorrect login and password will be redirected to login page' do
    get session_create_url, params: { login: 'fghyuji', password: 'njhbghgm' }
    assert_redirected_to session_login_url
  end

  test 'user with correct login and password can see his account' do
    password = 'user'
    user = User.create(username: 'user', password: password, password_confirmation: password)

    get session_create_url, params: { login: user.username, password: password }
    assert_redirected_to root_url

    get user_url(user)
    assert_response :success
  end

  test 'user can logout' do
    password = 'user1'
    user = User.create(username: 'user1', password: password, password_confirmation: password)

    get session_create_url, params: { login: user.username, password: password }
    get session_logout_url

    assert_redirected_to root_url
  end

  test 'should not update another user\'s post' do
    get session_login_url, params: { username: 'user1', password: 'user1', password_confirmation: 'user1'}
    assert_response :success
    @post = posts(:two)
    patch post_url(@post), params: { post: { text: @post.text, title: @post.title } }
    assert_redirected_to root_url
  end
  test 'should not delete another user\'s post' do
    get session_login_url, params: { username: 'user1', password: 'user1', password_confirmation: 'user1'}
    assert_response :success
    @post = posts(:two)
    delete post_url(@post), params: { post: { text: @post.text, title: @post.title } }
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
    put user_url(user), params: { username: 'user12', password: 'user12', password_confirmation: 'user12'}
    assert_redirected_to root_url
  end

end
