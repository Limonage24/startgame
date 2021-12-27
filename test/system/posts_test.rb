require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
    @user = users(:admin)
  end

  test 'visiting the index' do
    visit posts_url
    assert_selector 'h1', text: 'Инфакт'
  end

  test 'creating a Post' do
    visit session_login_url
    fill_in :password, with: 'admin'
    fill_in :login, with: 'admin'
    click_button 'login_btn'

    visit user_url(@user)
    click_button 'Создать новый пост'

    fill_in 'post_text', with: @post.text
    fill_in 'post_title', with: @post.title
    click_button 'Принять'

    assert_text 'Post was successfully created'
  end

  test 'updating a Post' do
    visit session_login_url
    fill_in :password, with: 'admin'
    fill_in :login, with: 'admin'
    click_button 'login_btn'

    visit post_url(@post)
    click_button 'edit_btn'

    p @post
    fill_in 'post_text', with: @post.text
    fill_in 'post_title', with: '@post.title'
    click_button 'Принять'

    assert_text 'Post was successfully updated'
  end

  test 'destroying a Post' do
    visit session_login_url
    fill_in :password, with: 'admin'
    fill_in :login, with: 'admin'
    click_button 'login_btn'

    visit post_url(@post)

    page.accept_confirm do
      click_button 'Удалить'
    end

    assert_text 'Post was successfully destroyed'
  end

end
