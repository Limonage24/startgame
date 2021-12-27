require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'should not save new empty User' do
    user = User.new
    assert !user.save
  end
  test 'should save not empty User' do
    user = User.new
    user.username = 'user'
    user.password_digest = BCrypt::Password.create('user')
    user.avatar = ''
    assert user.save
  end
end
