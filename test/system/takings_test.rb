require "application_system_test_case"

class TakingsTest < ApplicationSystemTestCase
  setup do
    @taking = takings(:one)
  end

  test "visiting the index" do
    visit takings_url
    assert_selector "h1", text: "Takings"
  end

  test "creating a Taking" do
    visit takings_url
    click_on "New Taking"

    fill_in "Course", with: @taking.course_id
    fill_in "Group", with: @taking.group_id
    fill_in "Student", with: @taking.student_id
    click_on "Create Taking"

    assert_text "Taking was successfully created"
    click_on "Back"
  end

  test "updating a Taking" do
    visit takings_url
    click_on "Edit", match: :first

    fill_in "Course", with: @taking.course_id
    fill_in "Group", with: @taking.group_id
    fill_in "Student", with: @taking.student_id
    click_on "Update Taking"

    assert_text "Taking was successfully updated"
    click_on "Back"
  end

  test "destroying a Taking" do
    visit takings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Taking was successfully destroyed"
  end
end
