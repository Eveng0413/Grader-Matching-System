require "application_system_test_case"

class RecommendsTest < ApplicationSystemTestCase
  setup do
    @recommend = recommends(:one)
  end

  test "visiting the index" do
    visit recommends_url
    assert_selector "h1", text: "Recommends"
  end

  test "should create recommend" do
    visit recommends_url
    click_on "New recommend"

    click_on "Create Recommend"

    assert_text "Recommend was successfully created"
    click_on "Back"
  end

  test "should update Recommend" do
    visit recommend_url(@recommend)
    click_on "Edit this recommend", match: :first

    click_on "Update Recommend"

    assert_text "Recommend was successfully updated"
    click_on "Back"
  end

  test "should destroy Recommend" do
    visit recommend_url(@recommend)
    click_on "Destroy this recommend", match: :first

    assert_text "Recommend was successfully destroyed"
  end
end
