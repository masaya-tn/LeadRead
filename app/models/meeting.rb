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
#  user_id     :bigint
#
# Indexes
#
#  index_meetings_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Meeting < ApplicationRecord
  belongs_to :user
end
