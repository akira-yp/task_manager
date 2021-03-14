require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'Title', with: 'testA'
        fill_in 'Content', with: 'test_contentA'
        click_button 'Create Task'
        expect(page).to have_content 'test_contentA'
      end
    end
  end
  describe '一覧表示機能' do
    let!(:task_a){FactoryBot.create(:task)}
    let!(:task_b){FactoryBot.create(:second_task)}
    let!(:task_c){FactoryBot.create(:third_task)}
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
        visit tasks_path
        task_list = all('.task_row')
        latest_task = task_list[0]
        expect(latest_task).to have_content "test_title3"
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         show_task = FactoryBot.create(:task)
         visit task_path(show_task.id)
         expect(page).to have_content 'test_title1'
       end
     end
  end
end
