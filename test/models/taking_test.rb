require 'test_helper'

class TakingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "belongs to" do
    should belong_to(:students)
  end
end
