# == Schema Information
#
# Table name: meetings
#
#  id          :bigint           not null, primary key
#  capacity    :integer          not null
#  date        :datetime         not null
#  description :text(65535)      not null
#  open        :boolean          default(TRUE), not null
#  title       :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class MeetingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
