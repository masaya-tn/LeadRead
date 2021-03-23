require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'メール、パスワードがある場合有効' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'メールが無い場合無効' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('が入力されていません。')
    end

    it 'パスワードが無い場合無効' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include('が入力されていません。')
    end

    it 'メールアドレスは一意であること' do
      user1 = create(:user)
      user2 = build(:user, email: user1.email)
      user2.valid?
      expect(user2.errors[:email]).to include('は既に使用されています。')
    end
  end

  describe 'インスタンスメソッド' do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let(:output_by_user_a) { create(:output, user: user_a) }
    let(:output_by_user_b) { create(:output, user: user_b) }
    let(:meeting_by_user_a) { create(:meeting, user: user_a) }
    let(:meeting_by_user_b) { create(:meeting, user: user_b) }

    describe 'own?' do
      context '自分のオブジェクトの場合' do
        it 'trueを返す' do
          expect(user_a.own?(output_by_user_a)).to be true
        end
      end

      context '自分以外のオブジェクトの場合' do
        it 'falseを返す' do
          expect(user_a.own?(output_by_user_b)).to be false
        end
      end
    end

    describe 'like' do
      it 'いいねできること' do
        expect { user_a.like(output_by_user_b) }.to change { Like.count }.by(1)
      end
    end

    describe 'unlike' do
      it 'いいねを解除できること' do
        user_a.like(output_by_user_b)
        expect { user_a.unlike(output_by_user_b) }.to change { Like.count }.by(-1)
      end
    end

    describe 'like?' do
      context 'いいねしている場合' do
        it 'trueを返す' do
          user_a.like(output_by_user_b)
          expect(user_a.like?(output_by_user_b)).to be true
        end
      end

      context 'いいねしていない場合' do
        it 'falseを返す' do
          expect(user_a.like?(output_by_user_b)).to be false
        end
      end
    end

    describe 'follow' do
      it 'フォローできること' do
        expect { user_a.follow(user_b) }.to change { Relationship.count }.by(1)
      end
    end

    describe 'unfollow' do
      it 'フォローを解除できること' do
        user_a.follow(user_b)
        expect { user_a.unfollow(user_b) }.to change { Relationship.count }.by(-1)
      end
    end

    describe 'following?' do
      context 'フォローしている場合' do
        it 'trueを返す' do
          user_a.follow(user_b)
          expect(user_a.following?(user_b)).to be true
        end
      end

      context 'フォローしていない場合' do
        it 'falseを返す' do
          expect(user_a.following?(user_b)).to be false
        end
      end
    end

    describe 'request' do
      it '読書会に参加申請できること' do
        expect { user_a.request(meeting_by_user_b) }.to change { Requesting.count }.by(1)
      end
    end

    describe 'unrequest' do
      it '参加申請を取り消せること' do
        user_a.request(meeting_by_user_b)
        expect { user_a.unrequest(meeting_by_user_b) }.to change { Requesting.count }.by(-1)
      end
    end

    describe 'request?' do
      context '参加申請している場合' do
        it 'trueを返す' do
          user_a.request(meeting_by_user_b)
          expect(user_a.request?(meeting_by_user_b)).to be true
        end
      end

      context '参加申請していない場合' do
        it 'falseを返す' do
          expect(user_a.request?(meeting_by_user_b)).to be false
        end
      end
    end

    describe 'participant?' do
      context '参加している場合' do
        it 'trueを返す' do
          user_a.request(meeting_by_user_b)
          meeting_by_user_b.permit(user_a)
          expect(user_a.participant?(meeting_by_user_b)).to be true
        end
      end

      context '参加していない場合' do
        it 'falseを返す' do
          expect(user_a.participant?(meeting_by_user_b)).to be false
        end
      end
    end
  end
end
