require 'test_helper'

class ShortenUrlTest < ActiveSupport::TestCase
  def setup
    @url = ShortenUrl.new(long_url: "www.example.com", short_url: "example")
  end

  test "should be valid" do
    assert @url.valid?
  end
  
    test "should accomodate transcription ambiguities" do
    # Add later
  end
  
    test "should not produce duplicate short URLs" do
      duplicate_url = @url.dup
      duplicate_url.short_url = @url.short_url.upcase
      @url.save
      assert_not duplicate_url.valid?
  end
  
    test "should not produce two short URLs that differ by only one character" do
    # Add later
  end
  
    test "should accept short_url with no inappropriate words" do
    @url.short_url = "test"
    assert @url.valid?, "#{@url.inspect} should be valid"
  end
  
    test "should catch short_url with inappropriate words" do
    @url.short_url = "FOO"
    assert_not @url.valid?, "#{@url.inspect} should be invalid"
    
    @url.short_url = "barfoo"
    assert_not @url.valid?, "#{@url.inspect} should be invalid"    
  end
  
    test "should accept long_url if valid" do
    valid_urls = %w[userexample.com USERfoo.COM ERfoo.bar.org
                         first.lastfoo.net aj-scarlet.edu]
    
    valid_urls.each do |valid_url|
      @url.long_url = valid_url
      assert @url.valid?, "#{valid_url.inspect} should be valid"
    end
  end
  
    test "should reject long_url if invalid" do
    invalid_urls = %w[userexample,com user_at_foo,org user.name@example.
                           foo@bar_baz@com foo@bar+baz,org]
                           
    invalid_urls.each do |invalid_url|
      @url.long_url = invalid_url
      assert_not @url.valid?, "#{invalid_url.inspect} should be invalid"
    end
    
  end
  
    test "should give user a warning if long_url is nil" do
      @url.long_url = nil
      assert_not @url.valid?
  end
  
      test "should not produce short_url longer than 10 characters" do
      @url.short_url = "a" * 11
      assert_not @url.valid?
  end
  
end