require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:admin)
    
  end

  test 'visiting the index' do
    visit session_login_url
    fill_in :password, with: 'admin'
    fill_in :login, with: 'admin'
    click_button 'login_btn'
    
    visit users_url
    assert_selector 'h1', text: 'Список пользователей'
  end

  test 'creating a User' do
    visit new_user_url

    fill_in 'avatar_field', with: ''
    fill_in 'user_password', with: 'user3'
    fill_in 'user_password_confirmation', with: 'user3'
    fill_in 'username_field', with: 'user3'
    click_button 'Далее'

    assert_text 'User was successfully created'
  end

  test 'updating a User' do
    visit session_login_url
    fill_in :password, with: 'admin'
    fill_in :login, with: 'admin'
    click_button 'login_btn'

    visit user_url(@user)
    click_button 'Редактировать профиль'

    fill_in 'avatar_field', with: ''
    fill_in 'user_password', with: 'admin'
    fill_in 'user_password_confirmation', with: 'admin'
    fill_in 'username_field', with: 'admin2'
    click_button 'Далее'

    assert_text 'User was successfully updated'
  end

  test 'destroying a User' do
    visit session_login_url
    fill_in :password, with: 'admin'
    fill_in :login, with: 'admin'
    click_button 'login_btn'

    visit user_url(@user)

    page.accept_confirm do
      click_button 'del_btn'
    end

    assert_text 'User was successfully destroyed'
  end
end
