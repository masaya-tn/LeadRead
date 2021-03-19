#  id          :bigint           not null, primary key
#  capacity    :integer          not null
#  date        :datetime         not null
#  description :text(65535)      not null
#  open        :boolean          default(TRUE), not null
#  title       :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint

# validate :before_today
#     def before_today
#       unless date == nil
#         errors.add(:date, '過去の日付は登録できません') if date < Date.today.to_time
#       end
#     end

#   def permit?(user)
#     participants.exists?(user_id: user.id)
#   end

#   def permit(user)
#     participanting_users << user
#   end

#   def after_now?
#     date > Date.today.to_time
#   end

require 'rails_helper'
require 'date'

RSpec.describe Meeting, type: :model do
  describe 'バリデーション' do
    it 'タイトル、説明、定員、日付があれば有効であること' do
      meeting = build(:meeting)
      expect(meeting).to be_valid
    end

    it 'タイトルが必須であること' do
      meeting = build(:meeting, title: nil)
      meeting.valid?
      expect(meeting.errors[:title]).to include('を入力してください')
    end

    it '説明が必須であること' do
      meeting = build(:meeting, description: nil)
      meeting.valid?
      expect(meeting.errors[:description]).to include('を入力してください')
    end

    it '定員が必須であること' do
      meeting = build(:meeting, capacity: nil)
      meeting.valid?
      expect(meeting.errors[:capacity]).to include('を入力してください')
    end

    it '日付が必須であること' do
      meeting = build(:meeting, date: nil)
      meeting.valid?
      expect(meeting.errors[:date]).to include('を入力してください')
    end
  end

  describe 'インスタンスメソッド' do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let(:meeting_by_user_a) { create(:meeting, user: user_a) }
    describe 'before_today' do
      it '過去の日付は無効である' do
        meeting = build(:meeting, date: Date.today - 1)
        meeting.valid?
        expect(meeting.errors[:date]).to include('過去の日付は登録できません')
      end
    end

    describe 'permit' do
      it '参加申請を許可できる' do
        user_b.request(meeting_by_user_a)
        expect { meeting_by_user_a.permit(user_b) }.to change { Participant.count }.by(1)
      end
    end

    describe 'permit?' do
      context '許可されている場合' do
        it 'trueを返す' do
          user_b.request(meeting_by_user_a)
          meeting_by_user_a.permit(user_b)
          expect(meeting_by_user_a.permit?(user_b)).to be true
        end
      end

      context '許可されていない場合' do
        it 'falseを返す' do
          expect(meeting_by_user_a.permit?(user_b)).to be false
        end
      end
    end
  end
end
