require 'test_helper'

class UrlsCreateTest < ActionDispatch::IntegrationTest
  test "invalid url information" do
    get root_path
    assert_no_difference 'Url.count' do
      post urls_path, url: { long_url:  "",
                            short_url: "url@invalid"}
    end
    assert_template 'urls/new'
  end
  
    test "valid url information" do
    get root_path
    assert_difference 'Url.count', 1 do
      post_via_redirect urls_path, url: { long_url:  "www.example1.com",
                                           short_url: "Example1"}
    end
    assert_template 'urls/show'
  end
end
