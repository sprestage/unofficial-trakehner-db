require 'minitest/autorun'
require "test_helper"

class BreederShowIndexTest < ActionDispatch::IntegrationTest

  test "Site visitor successfully see all breeders in the index" do
    puts "Site visitor successfully see all breeders in the index"
    # Given existing breeders
    # When I visit the breeders path
    visit breeders_path
    # Then I should see all breeders
    assert_includes(body, breeders(:meadowview).name)
    assert_includes(body, breeders(:blessed_fields).name)
  end

end
