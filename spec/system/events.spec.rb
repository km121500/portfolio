require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
      before do
        user_a = FactoryBot.create(:user, mame: 'ユーザーA',email: 'a@example.com')
        FactoryBot.create(:task,name: '最初のタスク', user: user_a)
      end

    context 'ユーザーがログインしているとき' do
      before do
        visit login_path 
        fill_in 'メールアドレス'.with: 'a@xample.com'
        fill_in 'パスワード',with'password'
        crick_button'ログインする'
      end
    end
  end  
end