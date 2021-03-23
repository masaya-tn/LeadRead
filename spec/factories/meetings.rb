#  capacity    :integer          not null
#  date        :datetime         not null
#  description :text(65535)      not null
#  open        :boolean          default(TRUE), not null
#  title       :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
require 'date'

FactoryBot.define do
  factory :meeting do
    title { Faker::Book.title }
    description { 'aaaaaaaaaaaaaaaaaaaaa' }
    capacity { 4 }
    date { Date.tomorrow.to_time }
    user
  end
end
