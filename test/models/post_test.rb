require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @post = Post.new(id: 1, title: "title", creator:"test creator",content: "test content",created_at: Time.now, updated_at: Time.now)
  end

  test "should be valid" do
    assert @post.valid?
  end


end
