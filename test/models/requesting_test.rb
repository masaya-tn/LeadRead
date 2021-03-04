# == Schema Information
#
# Table name: requestings
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  meeting_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_requestings_on_meeting_id              (meeting_id)
#  index_requestings_on_user_id                 (user_id)
#  index_requestings_on_user_id_and_meeting_id  (user_id,meeting_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (meeting_id => meetings.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class RequestingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
