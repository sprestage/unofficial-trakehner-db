require 'minitest/autorun'
require "test_helper"

class BreederSearchTest < ActionDispatch::IntegrationTest

  test "Search for empty name string (should match all breeders)" do
    puts "Search for empty name string (should match all breeders)"
    visit breeders_path
    fill_in "search_name", with: ""
    click_on "Search Breeder By Name"

    assert_includes(body, breeders(:tabarah).name)
    assert_includes(body, breeders(:meadowview).name)
    assert_includes(body, breeders(:blessed_fields).name)
  end

  test "Search for some breeders by name" do
    puts "Search for some breeders by name"
    visit breeders_path
    fill_in "search_name", with: "t"
    click_on "Search Breeder By Name"

    assert_includes(body, breeders(:tabarah).name)
    assert_includes(body, breeders(:breeder01).name)
    refute_includes(body, breeders(:meadowview).name)
    refute_includes(body, breeders(:blessed_fields).name)
  end

end
