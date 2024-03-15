require 'minitest/autorun'
require "test_helper"

class HorseShowIndexTest < ActionDispatch::IntegrationTest

  test "Site visitor successfully sees horses in the index" do
    puts "Site visitor successfully sees horses in the index"
    # Given existing horses
    # When I visit the horses path
    visit horses_path
    # Then I should see all horses
    assert_includes(body, horses(:abdullah).name)
    assert_includes(body, horses(:abiza).name)
  end

  test "Successfully see pagination of horses in the index" do
    puts "Successfully see pagination of horses in the index"
    # Given existing horses
    # When I visit the horses path
    visit horses_path
    # Then I should see pagination links and only see the first 25 horses alphabetically
    assert_includes(body, "Next")
    assert_includes(body, "Last")
    refute_includes(body, horses(:zzz).name)
  end

  test "successfully follow pagination of horses in the index" do
    puts "Successfully follow pagination of horses in the index"
    # Given existing horses
    # When I visit the horses path, I only see the first 25 horses alphabetically
    visit horses_path
    assert_includes(body, horses(:abdullah).name)
    refute_includes(body, horses(:zzz).name)
    # Then follow pagination link and only see the next 25 horses alphabetically
    click_on "Next"
    assert_includes(body, horses(:zzz).name)
    refute_includes(body, horses(:abdullah).name)
  end

end
