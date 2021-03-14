#  id             :bigint           not null, primary key
#  action_content :text(65535)      not null
#  book_image     :string(255)
#  book_title     :string(255)      not null
#  notion         :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#

FactoryBot.define do
  factory :action_plan do
    action_content { 'aaaaaaaaa' }
    book_title { 'タイトル' }
    user
  end
end
