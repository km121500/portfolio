require 'rails_helper'

describe '投稿のテスト' do

    describe '詳細画面のテスト' do
      before do
        @user = create(:user,name: 'name',email: 'a@example.com',password: 'test123')
        @event = create(:event, user_id: @user.id, title: 'hoge',body: 'body',place: 'place', date: '日付',image_id: 'fakdjfkdj')
        visit new_user_session_path
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: @user.password
        click_button "ログイン"
        visit event_path(@event)
      end

      context '表示の確認' do
        it 'イベントのタイトルと説明が画面に表示されていること' do
          expect(page).to have_content @event.title
          expect(page).to have_content @event.body
        end
        it 'Editリンクが表示される' do
          edit_link = find_all('a')[12]
          expect(edit_link.native.inner_text).to match("編集")
        end
      end
      context 'リンクの遷移先の確認' do
        it 'Editの遷移先は編集画面か' do
          edit_link = find_all('a')[12]
          edit_link.click
          expect(current_path).to eq('/events/' + @event.id.to_s + '/edit')
        end
      end
    end

    describe '編集画面のテスト' do
      before do
        @user = create(:user,name: 'name',email: 'a@example.com',password: 'test123')
        @event = create(:event, user_id: @user.id, title: 'hoge',body: 'body',place: 'place', date: '日付',image_id: 'fakdjfkdj')
        visit new_user_session_path
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: @user.password
        click_button "ログイン"
        visit edit_event_path(@event)
      end
      context '表示の確認' do
        it '編集前のタイトルと感想がフォームに表示(セット)されている' do
          expect(page).to have_field 'event[title]', with: @event.title
          expect(page).to have_field 'event[body]', with: @event.body
        end
        it '送信ボタンが表示される' do
          expect(page).to have_button '投稿'
        end
      end
      context '更新処理に関するテスト' do
        it '更新に成功しサクセスメッセージが表示されるか' do
        fill_in 'event[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'event[body]', with: Faker::Lorem.characters(number:20)
        click_button '投稿'
        expect(page).to have_content 'You have updated book successfully.'
      end
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'event[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'event[body]', with: Faker::Lorem.characters(number:20)
        click_button '投稿'
        expect(page).to have_current_path event_path(@event)
      end
      end
    end
end