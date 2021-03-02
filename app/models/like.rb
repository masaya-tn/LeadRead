# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  output_id  :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_likes_on_output_id              (output_id)
#  index_likes_on_user_id                (user_id)
#  index_likes_on_user_id_and_output_id  (user_id,output_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (output_id => outputs.id)
#  fk_rails_...  (user_id => users.id)
#
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :output

  
end
