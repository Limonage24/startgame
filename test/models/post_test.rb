require "test_helper"

class PostTest < ActiveSupport::TestCase
  test 'should not save new empty Post' do
    post = Post.new
    assert !post.save
  end
  test 'should save not empty Post' do
    post = Post.new
    post.title = 'Test'
    post.text = '<text>fdngjhgb</text>'
    post.author = 1
    assert post.save
  end
end
