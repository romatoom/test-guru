require "application_system_test_case"

class TestsTest < ApplicationSystemTestCase
  setup do
    @test = tests(:one)
  end

  test "visiting the index" do
    visit tests_url
    assert_selector "h1", text: "Tests"
  end

  test "creating a Test" do
    visit tests_url
    click_on "New Test"

    fill_in "Author", with: @test.author
    fill_in "Category", with: @test.category
    fill_in "Level", with: @test.level
    fill_in "Title", with: @test.title
    click_on "Create Test"

    assert_text "Test was successfully created"
    click_on "Back"
  end

  test "updating a Test" do
    visit tests_url
    click_on "Edit", match: :first

    fill_in "Author", with: @test.author
    fill_in "Category", with: @test.category
    fill_in "Level", with: @test.level
    fill_in "Title", with: @test.title
    click_on "Update Test"

    assert_text "Test was successfully updated"
    click_on "Back"
  end

  test "destroying a Test" do
    visit tests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Test was successfully destroyed"
  end
end
