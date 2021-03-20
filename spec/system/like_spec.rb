require 'rails_helper'

RSpec.describe 'いいね', type: :system do
  describe 'いいね' do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let(:output_by_user_b) { create(:output) }
    before do
      login_as user_a
    end
    it 'いいねできること' do
      visit output_path(output_by_user_b) 
      find('.like-button').click
      expect(page).to have_css('.unlike-button')
      expect(page).not_to have_css('.like-button')
    end

    it 'いいね解除できること' do
      visit output_path(output_by_user_b) 
      find('.like-button').click
      find('.unlike-button').click
      expect(page).to have_css('.like-button')
      expect(page).not_to have_css('.unlike-button')
    end
  end

  
end