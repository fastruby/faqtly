require "test_helper"

class TagTest < Test::Unit::TestCase
  def test_it_requires_all_fields
    @tag = Tag.new
    assert_equal @tag.valid?, false
  end
end