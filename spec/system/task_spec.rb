require 'rails_helper'
require 'date'

RSpec.describe 'タスク管理機能', type: :system do

  let!(:a_user){FactoryBot.create(:admin_user)}
  let!(:f_user){FactoryBot.create(:first_user)}
  let!(:s_user){FactoryBot.create(:second_user)}

  let!(:tag1){FactoryBot.create(:tag_1)}
  let!(:tag2){FactoryBot.create(:tag_2)}
  let!(:tag3){FactoryBot.create(:tag_3)}

  let!(:task_a){FactoryBot.create(:first_task, user_id: f_user.id)}
  let!(:task_b){FactoryBot.create(:second_task, user_id: f_user.id)}
  let!(:task_c){FactoryBot.create(:third_task, user_id: f_user.id)}

  before do
    task_a.tags << [tag1,tag2]
  end

  describe '新規作成機能' do

    before do
      visit new_session_path
      fill_in 'e-mail', with:'second_user@test.com'
      fill_in 'パスワード', with:'password'
      click_button 'ログイン'
    end
    context 'タスクを新規作成した場合' do
      before do
        visit new_task_path
        test_day = DateTime.now
        fill_in 'タスク名', with: 'testA'
        fill_in '内容', with: 'test_contentA'
        fill_in '終了期限', with: test_day
        select '未着手',from:'task_status'
        check '学習'
        check '買物'
        click_button '登録する'
      end
      it '作成したタスクが表示される' do
        expect(page).to have_content 'testA'
        expect(page).to have_content 'test_contentA'
        expect(page).to have_content '未着手'
      end
      it '複数のラベルが登録できる' do
        expect(page).to have_content '学習'
        expect(page).to have_content '買物'
      end
      it '詳細画面にラベル一覧が表示される' do
        click_on '詳細'
        expect(page).to have_content '学習'
        expect(page).to have_content '買物'
      end
    end
  end
  describe '一覧表示機能' do
    before do
      visit new_session_path
      fill_in 'e-mail', with:'first_user@test.com'
      fill_in 'パスワード', with:'password'
      click_button 'ログイン'
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'test_title1'
      end
    end
    context 'タスクが作成日の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        expect(page.first('.task-title')).to have_content "test_title3"
      end
    end
    context '終了期限でソートした場合' do
      it '終了期限が最も古いタスクが一番上に表示される' do
        click_link '終了期限'
        expect(page.first('.task-title')).to have_content "test_title1"
      end
    end
    context '優先順位でソートした場合' do
      it '優先順位が最も高いタスクが一番上に表示される' do
        click_link '優先度'
        expect(page.first('.task-title')).to have_content "test_title3"
      end
    end
  end
  describe '検索機能' do
    before do
      visit new_session_path
      fill_in 'e-mail', with:'first_user@test.com'
      fill_in 'パスワード', with:'password'
      click_button 'ログイン'
      visit tasks_path
    end
    context 'タイトルであいまい検索をした場合' do
      it '検索キーワードを含むタスクが絞り込まれる' do
        fill_in 'タスク名', with:'title1'
        click_button '検索'
        expect(page).to have_content 'test_title1'
      end
    end
    context 'ステータスで検索をした場合' do
      it '検索ステータスに完全一致するタスクが絞り込まれる' do
        select '着手中',from:'ステータス'
        click_button '検索'
        expect(page).to have_content 'test_title2'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
        fill_in 'タスク名', with:'title'
        select '完了', from:'ステータス'
        click_button '検索'
        expect(page).to have_content 'test_title3'
      end
      it '検索キーワードしか一致していないタスクは絞り込まれない' do
        fill_in 'タスク名', with:'title'
        select '完了', from:'ステータス'
        click_button '検索'
        expect(page).to have_no_content 'test_title1'
      end
    end
    context 'ラベルで絞りこんだ場合' do
      it '指定したラベルを含むタスクのみが表示される' do
        select '仕事', from: 'ラベル'
        click_button '検索'
        expect(page).to have_content 'test_title1'
        expect(page).to have_no_content 'test_title2'
        expect(page).to have_no_content 'test_title3'
      end
    end
  end
  describe '詳細表示機能' do
    before do
      visit new_session_path
      fill_in 'e-mail', with:'first_user@test.com'
      fill_in 'パスワード', with:'password'
      click_button 'ログイン'
    end
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         visit task_path(task_a.id)
         expect(page).to have_content 'test_title1'
       end
       it 'ラベルが表示される' do
         visit task_path(task_a.id)
         expect(page).to have_content '学習'
         expect(page).to have_content '仕事'
       end
     end
  end
  describe 'ラベル作成機能' do
    context '管理者権限でラベルを作成した場合' do
      before do
        visit new_session_path
        fill_in 'e-mail', with:'admin@test.com'
        fill_in 'パスワード', with:'password'
        click_button 'ログイン'
        click_link 'ラベル作成'
      end
      it '作成したラベルが追加される' do
        fill_in 'ラベル名', with:'サンプル'
        click_button '作成'
        expect(page).to have_content 'サンプル'
      end
    end
  end
end
