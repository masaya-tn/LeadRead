require 'rails_helper'

RSpec.describe Output, type: :model do
  describe 'バリデーション' do
    let(:user) { create(:user) }
    let(:output) { create(:output, user: user) }
    it 'タイトル、本文がある場合有効' do
      expect(output).to be_valid
    end

    it 'タイトルが必須であること' do
      output = build(:output, title: nil)
      output.valid?
      expect(output.errors[:title]).to include('が入力されていません。')
    end

    it '本文が必須であること' do
      output = build(:output, body: nil)
      output.valid?
      expect(output.errors[:body]).to include('が入力されていません。')
    end
  end
end
