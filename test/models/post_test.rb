require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save post without title" do
    new_post = Post.new
    assert_not new_post.save, "Saved the post without a title"
  end
end
