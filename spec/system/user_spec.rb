require 'rails_helper'

RSpec.describe 'ユーザー機能', type: :system do

  let!(:a_user){ FactoryBot.create(:admin_user)}
  let!(:f_user){ FactoryBot.create(:first_user)}
  let!(:s_user){ FactoryBot.create(:second_user)}

  describe 'ユーザー登録機能' do
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

  describe 'ログイン機能' do
    before do
      visit new_session_path
      fill_in 'e-mail', with:'first_user@test.com'
      fill_in 'パスワード', with:'password'
      click_button 'ログイン'
    end
    it 'ユーザーのタスク一覧ページが表示される' do
      expect(page).to have_selector'h2', text:'タスク一覧'
    end
    context 'マイページをクリックした場合' do
      it 'そのユーザーの詳細画面に遷移する' do
        click_link 'マイページ'
        expect(page).to have_selector'h2', text:'first_userさんのマイページ'
      end
    end
    context '他人の詳細ページを表示しようとした場合' do
      it 'タスク一覧画面に遷移する' do
        visit user_path(s_user.id)
        expect(page).to have_selector 'h2',text:'タスク一覧'
      end
    end
    context 'ログアウトをクリックした場合' do
      it 'ログアウトしてログインページに遷移する' do
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        expect(page).to have_selector 'h2',text:'ログイン'
      end
    end
  end

  describe 'ユーザー管理画面テスト' do
    context '管理ユーザーでログインした場合' do
      before do
        visit new_session_path
        fill_in 'e-mail', with:'admin@test.com'
        fill_in 'パスワード', with:'password'
        click_button 'ログイン'
      end
      it '管理画面を表示する' do
        expect(page).to have_selector 'h2',text:'ユーザー一覧'
      end
      context '新規登録した場合' do
        before do
          click_link 'ユーザー登録'
          fill_in '名前', with:'test8'
          fill_in 'e-mail', with:'test8@test.com'
          fill_in 'パスワード', with:'password'
          fill_in 'パスワード確認', with:'password'
          click_button '登録する'
        end
        it '登録したユーザーが表示される' do
          expect(page).to have_content 'test8'
        end
      end
      context '詳細画面にアクセスした場合' do
        it 'ユーザーの詳細画面が表示される' do
          first('.user_row').click_link('詳細')
          expect(page).to have_selector 'h2',text:'second_userさんのマイページ'
        end
      end
      context 'ユーザー情報を編集した場合' do
        before do
          first('.user_row').click_link('編集')
          fill_in '名前', with:'change_second_user'
          click_button '登録する'
        end
        it 'ユーザー情報が変更される' do
          expect(page).to have_content 'change_second_user'
        end
      end
      context 'ユーザーを削除した場合' do
        before do
          page.accept_confirm do
            first('.user_row').click_link('削除')
          end
        end
        it '一覧画面からユーザー名が消える'do
          expect(page).not_to have_content 'second_user'
        end
      end
    end
    context '一般ユーザーが管理画面にアクセスした場合' do
      before do
        visit new_session_path
        fill_in 'e-mail', with:'first_user@test.com'
        fill_in 'パスワード', with:'password'
        click_button 'ログイン'
        visit admin_users_path
      end
      it 'タスク一覧画面に飛ばされる' do
        expect(page).to have_selector 'h2',text:'タスク一覧'
      end
    end
  end
end
