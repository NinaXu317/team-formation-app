require "application_system_test_case"

class HoldprojectsTest < ApplicationSystemTestCase
  setup do
    @holdproject = holdprojects(:one)
  end

  test "visiting the index" do
    visit holdprojects_url
    assert_selector "h1", text: "Holdprojects"
  end

  test "creating a Holdproject" do
    visit holdprojects_url
    click_on "New Holdproject"

    fill_in "Course", with: @holdproject.course_id
    fill_in "Position", with: @holdproject.position
    fill_in "Project name", with: @holdproject.project_name
    click_on "Create Holdproject"

    assert_text "Holdproject was successfully created"
    click_on "Back"
  end

  test "updating a Holdproject" do
    visit holdprojects_url
    click_on "Edit", match: :first

    fill_in "Course", with: @holdproject.course_id
    fill_in "Position", with: @holdproject.position
    fill_in "Project name", with: @holdproject.project_name
    click_on "Update Holdproject"

    assert_text "Holdproject was successfully updated"
    click_on "Back"
  end

  test "destroying a Holdproject" do
    visit holdprojects_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Holdproject was successfully destroyed"
  end
end
