require "test_helper"


class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @current_user = users(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get session_create_url, params: { login: 'user1', password: 'user1' }
    assert_redirected_to root_url
    get new_post_url
    assert_response :success
  end

  test "should create new" do
    get session_create_url, params: { login: 'user1', password: 'user1' }
    assert_redirected_to root_url
    post posts_url, params: { post: { title: @post.title }, text: [@post.text] }
    assert_response :redirect
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get session_create_url, params: { login: 'user1', password: 'user1' }
    assert_redirected_to root_url
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    get session_create_url, params: { login: 'user1', password: 'user1' }
    assert_redirected_to root_url
    patch post_url(@post), params: { post: { title: @post.title }, text: [@post.text] }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    get session_create_url, params: { login: 'user1', password: 'user1' }
    assert_redirected_to root_url
    delete post_url(@post)
    assert_redirected_to posts_url
    assert_raises(ActiveRecord::RecordNotFound) { get post_url(@post) }
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
end
