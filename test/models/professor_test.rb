require 'test_helper'

class ProfessorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "have many" do
    should have_many(:courses)
  end
end
