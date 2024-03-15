require 'minitest/autorun'
require "test_helper"

class HorseShowTest < ActionDispatch::IntegrationTest

  test "site visitor successfully sees Jakira and parts of her pedigree" do
    puts "site visitor successfully sees Jakira and parts of her pedigree"
    visit horses_path
    click_on("Jakira")

    assert_includes(body, horses(:jakira).name.upcase)
    assert_includes(body, horses(:ichiban).name)
    assert_includes(body, horses(:arogno).name)

    refute_includes(body, horses(:abdullah).name)
    refute_includes(body, "Unknown")
  end

  # Regression test: for a brief moment, the links in a horse's pedigree
  # to the horses listed there would lead back to the horse who's pedigree
  # it was (aka the horse being displayed), rather than to the page of the
  # horse named in the link
  test "Horses in pedigree have correct link in their href" do
    puts "Horses in pedigree have correct link in their href"
    visit horses_path
    click_on("Polarpunkt")

    click_on horses(:arogno).name

    refute_includes(body, horses(:polarpunkt).name)
    refute_includes(body, horses(:polarpunkt).name.upcase)
  end

  test "A horses's progeny are successfully displayed" do
    puts "A horses's progeny are successfully displayed"
    # Given a horse has progeny
    visit horse_path(horses(:jaegerin))
    # When visit the progeny path
    click_on("Show Progeny")
    # Then that horse's progeny are displayed
    assert_includes(body, horses(:joriah).name)
  end

end
