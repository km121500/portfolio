require 'rails_helper'

describe '投稿のテスト' do
    #let!(:user)  { create(:user,name: 'name',email: 'a@example.com',password: 'test123')}
   #let!(:event) { create(:event,title: 'hoge',body: 'body',place: 'place', date: '日付',image_id: 'fakdjfkdj') }
    # describe 'トップ画面(root_path)のテスト' do
    #   context '表示の確認' do
    #     it 'トップ画面(root_path)に一覧ページへのリンクが表示されているか' do
    #       expect(page).to have_link "", href: books_path
    #     end
    #     it 'root_pathが"/"であるか' do
    #       expect(current_path).to eq('/')
    #     end
    # end
    # end
  # describe "一覧画面のテスト" do
  #     before do
  #       visit books_path
  #     end
  #   context '一覧の表示とリンクの確認' do
  #     it "bookの一覧表示(tableタグ)と投稿フォームが同一画面に表示されているか" do
  #       expect(page).to have_selector 'table'
  #       expect(page).to have_field 'book[title]'
  #       expect(page).to have_field 'book[body]'
  #     end
  #     it "bookのタイトルと感想を表示し、詳細・編集・削除のリンクが表示されているか" do
  #       (1..5).each do |i|
  #         Book.create(title:'hoge'+i.to_s,body:'body'+i.to_s)
  #       end
  #     visit books_path
  #     Book.all.each_with_index do |book,i|
  #     j = i * 3
  #     expect(page).to have_content book.title
  #     expect(page).to have_content book.body
  #     # Showリンク
  #     show_link = find_all('a')[j]
  #     expect(show_link.native.inner_text).to match(/show/i)
  #     expect(show_link[:href]).to eq book_path(book)
  #     # Editリンク
  #     show_link = find_all('a')[j+1]
  #     expect(show_link.native.inner_text).to match(/edit/i)
  #     expect(show_link[:href]).to eq edit_book_path(book)
  #     # Destroyリンク
  #     show_link = find_all('a')[j+2]
  #     expect(show_link.native.inner_text).to match(/destroy/i)
  #     expect(show_link[:href]).to eq book_path(book)
  #     end
  #   end
  #     it 'Create Bookボタンが表示される' do
  #       expect(page).to have_button 'Create Book'
  #     end
  #   end
  #     context '投稿処理に関するテスト' do
  #       it '投稿に成功しサクセスメッセージが表示されるか' do
  #       fill_in 'book[title]', with: Faker::Lorem.characters(number:5)
  #       fill_in 'book[body]', with: Faker::Lorem.characters(number:20)
  #       click_button 'Create Book'
  #       expect(page).to have_content 'successfully'
  #     end
  #     it '投稿に失敗する' do
  #       click_button 'Create Book'
  #       expect(page).to have_content 'error'
  #       expect(current_path).to eq('/books')
  #     end
  #     it '投稿後のリダイレクト先は正しいか' do
  #       fill_in 'book[title]', with: Faker::Lorem.characters(number:5)
  #       fill_in 'book[body]', with: Faker::Lorem.characters(number:20)
  #       click_button 'Create Book'
  #       expect(page).to have_current_path book_path(Book.last)
  #     end
  #     end
  #     context 'book削除のテスト' do
  #       it 'bookの削除' do
  #         expect{ book.destroy }.to change{ Book.count }.by(-1)
  #         # ※本来はダイアログのテストまで行うがココではデータが削除されることだけをテスト
  #       end
  #     end
  #   end
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
          edit_link = find_all('a')[10]
          expect(edit_link.native.inner_text).to match("編集")
        end
      end
      context 'リンクの遷移先の確認' do
        it 'Editの遷移先は編集画面か' do
          edit_link = find_all('a')[10]
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
        it '更新に失敗しエラーメッセージが表示されるか' do
        fill_in 'event[title]', with: ""
        fill_in 'event[body]', with: ""
        click_button '投稿'
        expect(page).to have_content '内容は1文字以上入力してください。'
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