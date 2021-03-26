require 'rails_helper'
require 'date'

RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title:'', content:'バリデーションテスト', expired_at: DateTime.now )
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title:'バリデーションテスト', content:'',expired_at: DateTime.now )
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title:'バリデーションテスト', content:'バリデーションテスト', expired_at: DateTime.now )
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:task_a){ FactoryBot.create(:first_task) }
    let!(:task_b){ FactoryBot.create(:second_task) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it '検索キーワードを含むタスクが絞り込まれる' do
        expect(Task.search_title('test_title1')).to include(task_a)
        expect(Task.search_title('test_title1')).not_to include(task_b)
        expect(Task.search_title('test_title1').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.search_status('未着手')).to include(task_a)
        expect(Task.search_status('未着手')).not_to include(task_b)
        expect(Task.search_status('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かるステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.search_title('test_title').search_status('着手中')).to include(task_b)
        expect(Task.search_title('test_title').search_status('着手中')).not_to include(task_a)
        expect(Task.search_title('test_title').search_status('着手中').count).to eq 1
      end
    end
  end
end
