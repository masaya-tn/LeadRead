require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'バリデーション' do
    it '本文があれば有効であること' do
      message = build(:message)
      expect(message).to be_valid
    end

    it '本文が必須であること' do
      message = build(:message, body: nil)
      message.valid?
      expect(message.errors[:body]).to include('を入力してください')
    end
  end
end
