FactoryBot.define do
  factory :message do
    body { 'aaaaaa' }
    user
    meeting
  end
end
