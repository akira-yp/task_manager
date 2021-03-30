require 'rails_helper'
require 'date'
RSpec.describe 'ユーザー機能', type: :system do
  context 'ユーザー新規登録した場合' do
    before do
      visit new_user_path
      fill_in '名前', with:'test8'
      fill_in 'e-mail', with:'test8@test.com'
      fill_in 'パスワード', with:'password'
      fill_in 'パスワード確認', with:'password'
      click_button '登録する'
    end
    it 'ユーザーテーブルに登録される' do
      expect(User.last).to include("test8")
    end
  end
  context 'ログインせずに一覧画面にアクセスした場合' do
    before do
    visit tasks_path
    end
    it 'ログインページが表示される' do
      expect(page).to have_content 'ログイン画面'
    end
  end
  end
end
