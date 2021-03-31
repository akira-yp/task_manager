require 'rails_helper'
require 'date'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:f_user){FactoryBot.create(:first_user)}
  let!(:task_a){FactoryBot.create(:first_task)}
  let!(:task_b){FactoryBot.create(:second_task)}
  let!(:task_c){FactoryBot.create(:third_task)}

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      before do
        visit new_task_path
        test_day = DateTime.now
        fill_in 'タスク名', with: 'testA'
        fill_in '内容', with: 'test_contentA'
        fill_in '終了期限', with: test_day
        select '未着手',from:'task_status'
        click_button '登録する'
      end
      it '作成したタスクが表示される' do
        expect(page).to have_content 'testA'
        expect(page).to have_content 'test_contentA'
        expect(page).to have_content '未着手'
      end
    end
  end
  describe '一覧表示機能' do
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'test_title1'
      end
    end
    context 'タスクが作成日の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        latest_task = task_list[0]
        expect(latest_task).to have_content "test_title3"
      end
    end
    context '終了期限でソートした場合' do
      before do
        click_on '終了期限'
      end
      it '終了期限が最も新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        oldest_deadline = task_list[0]
        expect(oldest_deadline).to have_content "test_title2"
      end
    end
    context '優先順位でソートした場合' do
      it '優先順位が最も高いタスクが一番上に表示される' do
        click_on '優先度'
        task_list = all('.task_row')
        highest_priority = task_list[0]
        expect(highest_priority).to have_content "test_title3"
      end
    end
  end
  describe '検索機能' do
    let!(:task_a){FactoryBot.create(:first_task)}
    let!(:task_b){FactoryBot.create(:second_task)}
    let!(:task_c){FactoryBot.create(:third_task)}
    before do
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
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         show_task = FactoryBot.create(:first_task)
         visit task_path(show_task.id)
         expect(page).to have_content 'test_title1'
       end
     end
  end
end
