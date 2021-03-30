require 'rails_helper'

RSpec.describe 'ユーザーモデル機能', type: :model do
  describe 'adminのテスト' do
    let!(:admin){ FactoryBot.create(:admin_user) }
    context '最後のadminユーザーを削除した場合' do
      it '削除されない' do
        admin.destroy
        expect(User.where(admin: true).count ).to eq 1
      end
    end
  end
end
