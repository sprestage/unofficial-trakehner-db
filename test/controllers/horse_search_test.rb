require 'minitest/autorun'
require "test_helper"

class HorseSearchTest < ActionDispatch::IntegrationTest

  test "Search for a horse" do
    puts "Search for a horse"
    visit root_path
    fill_in "search", with: "Jakira"
    click_on "Search"
    assert_includes(body, horses(:jakira).name)
    refute_includes(body, horses(:jaegerin).name)
    refute_includes(body, horses(:marduc).name)
    refute_includes(body, horses(:siegel).name)
  end

  test "Search for some horses" do
    puts "Search for some horses"
    visit root_path
    fill_in "search", with: "J"
    click_on "Search"
    assert_includes(body, horses(:jaegerin).name)
    assert_includes(body, horses(:jamilah).name)
    refute_includes(body, horses(:marduc).name)
    refute_includes(body, horses(:siegel).name)
  end

  test "Search for empty string (should match all horses)" do
    puts "Search for empty string (should match all horses)"
    visit root_path
    fill_in "search", with: ""
    click_on "Search"
    assert_includes(body, horses(:abiza).name)
    assert_includes(body, horses(:abdullah).name)
    assert_includes(body, horses(:arogno).name)
  end

  ### TODO: Need to get this working successfully.  The search
  ### doesn't seem to change when Has image is clicked.
  # scenario "Search for horses with images" do
  #   visit root_path
  #   check "Has image"
  #   click_on "Search"

  #   page.text.must_include horses(:abdullah).name
  #   page.text.must_include horses(:herrzauber).name
  #   page.text.must_include "NONO"
  #   page.wont_have_content horses(:jakira).name
  # end

end
