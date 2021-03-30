require 'rails_helper'

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
    it '新規登録成功のメッセージが表示される' do
      expect(page).to have_content("新規ユーザー登録しました")
    end
  end
  context 'ログインせずに一覧画面にアクセスした場合' do
    before do
    visit tasks_path
    end
    it 'ログインページが表示される' do
      expect(page).to have_selector 'h2', text:'ログイン'
    end
  end
end
