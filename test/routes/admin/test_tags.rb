require 'test_helper'

class TestTags < Test::Unit::TestCase
  def app
    Faqtly
  end

  def test_create_a_tag
    basic_authorize('admin', 'admin')
    post '/tags', tag: { name: "Payment Gateways" }
    assert_equal 302, last_response.status
  end

  def test_error_messages_on_failed_tag_create
    basic_authorize('admin', 'admin')
    old_count = Tag.count
    post '/tags', tag: { name: "" }
    assert last_response.body.include?("tag is not present")
    assert_equal old_count, Tag.count
  end

  def test_tags_edit
    @tag = Tag.create( name: 'Precios' )
    basic_authorize('admin', 'admin')
    get "/tags/#{@tag.permalink}/edit"
    assert_equal 200, last_response.status
    assert last_response.body.include?("method='put'")
  end

  def test_tags_new_for_authorized_user
    basic_authorize('admin', 'admin')
    get '/tags/new'
    assert last_response.body.include?("id='new-tags-form'")
  end  

  def test_tags_update
    @tag = Tag.create( name: 'Hosting' )

    basic_authorize('admin', 'admin')
    put "/tags/#{@tag.id}", tag: { name: "Servers" }
    assert_equal "Servers", Tag[@tag.id].name
  end
end
