#  id         :bigint           not null, primary key
#  author     :string(255)
#  body       :text(65535)      not null
#  book_image :string(255)
#  book_title :string(255)      not null
#  title      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint

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
      expect(output.errors[:title]).to include('を入力してください')
    end

    it '本文が必須であること' do
      output = build(:output, body: nil)
      output.valid?
      expect(output.errors[:body]).to include('を入力してください')
    end
  end
end
