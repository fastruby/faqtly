require 'test_helper'

class TestTags < Test::Unit::TestCase
  def test_create_a_tag
    authorize_user!
    post '/tags', tag: { name: "Payment Gateways" }
    assert_equal 200, page.status_code
  end

  def test_error_messages_on_failed_tag_create
    authorize_user!
    old_count = Tag.count
    post '/tags', tag: { name: "" }
    assert page.has_content?("tag is not present")
    assert_equal old_count, Tag.count
  end

  def test_tags_edit
    @tag = Tag.create( name: 'Precios' )
    authorize_user!
    visit "/tags/#{@tag.permalink}/edit"
    assert_equal 200, page.status_code
    assert page.has_xpath?("//input[@value='put']", visible: false)
  end

  def test_tags_new_for_authorized_user
    authorize_user!
    visit '/tags/new'
    assert page.has_css?("#new-tags-form")
  end

  def test_tags_update
    @tag = Tag.create( name: 'Hosting' )

    authorize_user!
    put "/tags/#{@tag.permalink}", {tag: { name: "Servers" }}
    assert_equal "Servers", Tag[@tag.id].name
  end
end
