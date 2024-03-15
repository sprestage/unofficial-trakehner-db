require 'minitest/autorun'
require "test_helper"

class LanguageSwitchingTest < ActionDispatch::IntegrationTest

  test "Swaps between languages" do
    puts "Swaps between languages"
    visit root_path
    assert_includes(body, "The Unofficial Trakehner Database")
    assert_title "The Unofficial Trakehner Database"
    click_on 'Deutsche'
    assert_includes(body, "Der Inoffiziell Trakehner Datenbank")
    assert_includes(body, "Pferde")
    click_on 'English'
    assert_includes(body, "The Unofficial Trakehner Database")
    assert_includes(body, "Horses")
  end

end
