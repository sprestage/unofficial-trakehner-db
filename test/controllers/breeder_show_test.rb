require 'minitest/autorun'
require "test_helper"

class BreederShowTest < ActionDispatch::IntegrationTest

  test "site visitor successfully sees Tabarah Ranch and parts of the address" do
    puts "site visitor successfully sees Tabarah Ranch and parts of the address"
    visit breeders_path
    click_on("Tabarah Ranch Trakehners - Susan Prestage")

    assert_includes(body, breeders(:tabarah).name)
    assert_includes(body, breeders(:tabarah).address)

    refute_includes(body, breeders(:meadowview).name)
    refute_includes(body, "Unknown")
  end

end
